class Admin::Partner::OauthApplicationsController < AdminController
  before_action :set_partner
  before_action :set_application

  def show
    @pagy, @access_tokens = pagy(@application.access_tokens, items: 5)
  end

  def edit;end

  def update
    if @application.update(application_params)
      redirect_to admin_partner_oauth_application_path(partner_id: @partner.id, id: @application.id), flash: { success: 'Application successfully updated.' }
    else
      render :edit
    end
  end

  def approve
    if @application.present?
      @application.update(approved_by_admin: true)
      # @partner.create_user_charging_session if @partner.user.blank?
      redirect_to admin_partner_oauth_application_path(partner_id: @partner.id, id: @application.id), flash: { success: 'Application successfully approved.' }
    else
      redirect_to admin_partner_path(@partner), flash: { error: 'Application failed to approve.' }
    end
  end

  def validate
    begin
      # verify their version
      ocpi_configuration = Ocpi::Application::Credentials::Services::FetchVersion.new(token: @application.credentials_token_a)
      result = ocpi_configuration.call(url: @application.ocpi_version_endpoint)
      if ocpi_configuration.valid?
        @application.update(ocpi_validation_status: :ocpi_valid)
        @application.generate_authorization
        flash[:success] = I18n.t(:notice, scope: %i[doorkeeper flash applications ocpi valid])
      else
        flash[:error] = I18n.t(:notice, scope: %i[doorkeeper flash applications ocpi invalid])
      end
      redirect_to admin_partner_oauth_application_path(partner_id: @partner.id, id: @application.id)
    rescue => exception
      flash[:error] = I18n.t(:notice, scope: %i[doorkeeper flash applications ocpi invalid]) + ' => ' + exception.to_s
      redirect_to admin_partner_oauth_application_path(partner_id: @partner.id, id: @application.id)
    end
  end

  def receive_push
    if @application.update(receive_push_model: params[:receive_push_model])
      status = params[:receive_push_model] == 'true' ? 'resumed' : 'paused'
      redirect_to admin_partner_oauth_application_path(partner_id: @partner.id, id: @application.id), flash: { success: "Push Model successfully #{status}" }
    else
      redirect_to admin_partner_oauth_application_path(partner_id: @partner.id, id: @application.id), flash: { error: 'Something went wrong' }
    end
  end

  def ocpi_modules
    @their_token = Ocpi::Domain::Credentials::Models::Credential.find params[:ocpi_credentials_id]
    @ocpi_modules = Ocpi::Domain::Versions::Models::Endpoint.joins(
        version_detail: {
          version: :credential
        }
      )
      .where("ocpi_credentials.id = ?", params[:ocpi_credentials_id])
      .order(identifier: :asc)
  end

  private
  def set_partner
    @partner = ::Partner::Partner.find_by_id(params[:partner_id])
  end

  def set_application
    @application = @partner.oauth_applications.find_by_id(params[:id])
  end

  def application_params
    params.require(:partner_application).permit(:name, :redirect_uri, :scopes, :confidential, :payment_gateway_webhook, :status_notification_webhook)
  end

end
