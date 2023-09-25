class Partner::AuthorizationsController < Doorkeeper::AuthorizationsController
  skip_forgery_protection
  before_action :get_application, only: [:create, :destroy]
  before_action :previous_path

  def create
    if @application.approved_by_admin?
      authorization = ::Partner::AccessGrant.new(redirect_uri: @application.redirect_uri, application_id: @application.id, expires_in: 3600, resource_owner_id: @application.owner.id, scopes: @application.scopes)
      if authorization.save
        @authorization = { message: 'Your application authorized!', is_success: true, authorization_code: authorization.token }
      else
        @authorization = { message: 'Something went wrong!', is_success: false, authorization_code: nil }
      end
    else
      @authorization = { message: 'You do not have authorization to access. <br> Waiting for Approval', is_success: false, authorization_code: nil }
    end
  end

  def show
    @access_grant = ::Partner::AccessGrant.find_by_token(params[:code])
  end

  def destroy
    access_grant = ::Partner::AccessGrant.find_by_id(params[:id])
    access_grant.destroy
    redirect_to oauth_application_path(@application.id), notice: 'Successfully destroyed'
  end

  private
  
  def get_application
    @application   = ::Partner::Application.find_by_uid(params[:client_id])
    @authorization = { message: 'Application not found', is_success: false, authorization_code: nil } if @application.blank?
  end

  def previous_path
    @previous_path = params[:previous_path]
  end
end