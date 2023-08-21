class Partner::BaseController < ActionController::Base
  layout 'partner'
  before_action :authenticate_partner!
  
  def authenticate_partner!
    return if partner_signed_in?
    redirect_to new_partner_session_path
  end
end