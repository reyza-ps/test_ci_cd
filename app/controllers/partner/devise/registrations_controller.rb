class Partner::Devise::RegistrationsController < Devise::RegistrationsController
  layout 'application'
  before_action :configure_sign_up_params

  private

  def after_inactive_sign_up_path_for(_resource)
    partner_root_path
  end

  def after_sign_up_path_for(_resource)
    partner_root_path
  end

  def after_update_path_for(_resource)
    partner_root_path
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[name address city state country postcode overview website_url
                                               mobile_phone logo party_id country_code])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name address city state country postcode overview website_url
                                               mobile_phone logo party_id country_code])
  end
end
