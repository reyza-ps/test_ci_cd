class Partner::OauthApplicationsController < Partner::BaseController
  before_action :set_application, only: %i[show edit update destroy]
  before_action :available_scopes, only: %i[new create edit update]
  before_action :available_ocpi_scopes, only: %i[ocpi_new ocpi_create ocpi_edit ocpi_update]

  def index
    @applications = current_partner.applications.order(id: :desc)
    @pagy, @applications = pagy(@applications, items: 5)
  end

  def new
    @application = current_partner.oauth_applications.new
  end

  def create
    @application = current_partner.oauth_applications.new(application_params)

    if @application.save
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications create])
      redirect_to oauth_applications_url
    else
      flash[:alert] = @application.errors.full_messages.first
      render :new
    end
  end

  def edit; end

  def update
    if @application.update(application_params)
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications update])
      redirect_to oauth_applications_url
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications destroy]) if @application.destroy

    redirect_to oauth_applications_url
  end

  def show
    @pagy, @access_tokens = pagy(@application.access_tokens, items: 5)
    @pagy_member, @members = pagy(@application.partners, items: 5)
  end

  def ocpi_modules
    @ocpi_modules = Ocpi::Domain::Versions::Models::Endpoint.joins(
      version_detail: {
        version: :credential
      }
    )
                                                            .where('ocpi_credentials.id = ?', params[:ocpi_credentials_id])
  end

  private

  def set_application
    @application = current_partner.applications.find_by_id(params[:id])
    return unless @application.blank?

    flash[:alert] = 'Applications not found or you do not have access'
    redirect_to partner_root_path and return
  end

  def available_scopes
    @scopes = [:ocpi_request]
  end

  def application_params
    params[:partner_application][:scopes] = 'ocpi_request' if params[:partner_application][:scopes].blank?
    if params[:partner_application][:scopes].include? :ocpi_token_c
      params[:partner_application][:scopes] = params[:partner_application][:scopes].reject do |scope|
        scope == :ocpi_token_c
      end
    end
    params.require(:partner_application).permit(:credentials_token_a, :ocpi_version_endpoint, :name, scopes: [])
  end
end
