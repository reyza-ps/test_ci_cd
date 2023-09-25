class Partner::TokensController < Doorkeeper::TokensController
  include ActionController::Flash
  before_action :get_application, only: [:create, :ocpi_connect, :ocpi_request, :ocpi_disconnect]

  def create
    begin
      response = strategy.authorize
      body     = response.body
      if response.status == :ok
        body[:id] = response.token.resource_owner_id unless nil
        Partner::AccessToken::create_relations(access_grant_token: params[:code], access_token: body['access_token'])
      end

      self.headers.merge! response.headers
      self.response_body = body.to_json
      self.status        = response.status
    rescue Exception => e
      render json: { message: e.to_s, is_success: false, access_token: nil }
    end
  end

  def ocpi_request
    begin
      response = strategy.authorize
      body     = response.body
      if response.status == :ok
        body[:id] = response.token.resource_owner_id unless nil
        current_access_token = Partner::AccessToken::create_relations(access_grant_token: params[:code], access_token: body['access_token'])
      end

      self.headers.merge! response.headers
      self.response_body = body.to_json
      self.status        = response.status
      response
    rescue Exception => e
      current_access_token.destroy if current_access_token.present?
      render json: { message: e.to_s, is_success: false, access_token: nil, status: 401 }
    end
  end

  def ocpi_connect
    current_access_token = Partner::AccessToken.find_by token: params[:token]
    application = current_access_token.application
    partner = application.owner
    RegisterToPartyJob.perform_async(params[:token])

    flash[:success] = 'Connected'
    if params[:partner].present? && params[:partner].to_s == 'true'
      redirect_to partner_ocpi_credential_path(application)
    else
      redirect_to admin_partner_oauth_application_path(partner_id: partner.id, id: application.id)
    end
  end

  def ocpi_disconnect
    current_access_token = Partner::AccessToken.find_by token: params[:token]
    application = current_access_token.application
    partner = application.owner
    extras = { id: application.id, environment: application.environment }
    result = Ocpi::Application::Credentials::Services::PushUnregister.new(credential_id: current_access_token.ocpi_credentials_id, extras: extras).call
    if result.destroyed? == true
      Partner::AccessToken::reset_ocpi_config!(current_access_token: current_access_token)
    end

    flash[:success] = 'Disconnected'
    if params[:partner].present? && params[:partner].to_s == 'true'
      redirect_to partner_ocpi_credential_path(application)
    else
      redirect_to admin_partner_oauth_application_path(partner_id: partner.id, id: application.id)
    end
  end

  private
  def get_application
    @application   = ::Partner::Application.find_by_uid(params[:client_id])
    @access_token = { message: 'Application not found', is_success: false, access_token: nil } if @application.blank?
  end

  
  # temp
  def register_to_party(application:)
    register_to_party = Ocpi::Application::Credentials::Services::RegisterToParty.new(token_a: application.credentials_token_a)
    register_to_party.call(url: application.ocpi_version_endpoint)
    register_to_party
  end
  
  # temp
end