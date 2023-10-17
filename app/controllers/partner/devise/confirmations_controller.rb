class Partner::Devise::ConfirmationsController < Devise::ConfirmationsController
  layout 'application'

  private

  def after_confirmation_path_for(_resource_name, _resource)
    new_partner_session_path
  end
end
