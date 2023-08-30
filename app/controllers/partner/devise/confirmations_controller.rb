
class Partner::Devise::ConfirmationsController < Devise::ConfirmationsController
  layout 'application'

  private

  def after_confirmation_path_for(resource_name, resource)
    new_partner_session_path
  end
end
