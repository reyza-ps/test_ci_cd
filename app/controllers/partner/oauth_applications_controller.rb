class Partner::OauthApplicationsController < Partner::BaseController
  before_action :set_application, only: %i[show edit update destroy]
  before_action :available_scopes, only: %i[new create edit update]

  def index
    # @applications = current_partner.oauth_applications.order(id: :desc)
    @applications = current_partner.applications.order(id: :desc)
  end

  def show
    @access_grants = @application.access_grants.joins(:access_token).order(id: :desc).page(params[:page])
    @members       = @application.partners
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
      render :new
    end
  end

  def edit;end

  def update
    if @application.update(application_params)
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications update])
      redirect_to oauth_applications_url
    else
      render :edit
    end
  end

  def destroy
    if @application.destroy
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications destroy])
    end

    redirect_to oauth_applications_url
  end

  private
    def set_application
      @application = current_partner.applications.find_by_id(params[:id])
      if @application.blank?
        flash[:alert] = 'Applications not found or you do not have access'
        redirect_to partner_root_path and return 
      end
    end

    def available_scopes
      @scopes = Partner::Application::SCOPES.reject{ |scope| scope.in?([:ocpi_token_c, :ocpi_request]) }
    end

    def application_params
      params[:partner_application][:scopes] = 'read' if params[:partner_application][:scopes].blank?
      params[:partner_application][:scopes] = params[:partner_application][:scopes].reject{ |scope| scope.in?([:ocpi_token_c, :ocpi_request]) }
      params.require(:partner_application).permit(:name, :redirect_uri, :confidential, :payment_gateway_webhook, :payment_webhook_key, :payment_webhook_secret, :status_notification_webhook, :status_notification_webhook_key, :status_notification_webhook_secret, scopes: [])
    end
end