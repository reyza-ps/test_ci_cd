class Partner::BaseController < ActionController::Base
  include Pagy::Backend
  
  layout 'partner'
  before_action :authenticate_partner!
  
  def authenticate_partner!
    return if partner_signed_in?
    redirect_to new_partner_session_path
  end

  def render_turbo_flash
    turbo_stream.update("flash", partial: "shared/flash")
  end
end