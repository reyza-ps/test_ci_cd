class Partner::Devise::SessionsController < Devise::SessionsController
  layout 'application'

  protected

  def after_sign_in_path_for(_resource)
    partner_root_url
  end

  def after_sign_out_path_for(_resource)
    partner_session_url
  end
end
