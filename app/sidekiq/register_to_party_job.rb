class RegisterToPartyJob
  include Sidekiq::Job

  def perform(token)
    current_access_token = Partner::AccessToken.find_by token: token
    application = current_access_token.application
    registration_result = Ocpi::Application::Credentials::Services::PushRegister.new(their_token: application.credentials_token_a)
    registration_result.call(url: application.ocpi_version_endpoint)
    Partner::AccessToken::update_to_token_c(access_token: current_access_token, ocpi_credential: registration_result.their_credential)
  end
end
