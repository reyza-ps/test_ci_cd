FactoryBot.define do
  factory :oauth_application, class: 'Partner::Application' do
    name { 'razer' }
    secret { 'secret' }
    scopes { ["write", "update", "read", "delete"] }
    approved_by_admin { true }
    ocpi_version_endpoint { 'http://localhost:3000/ocpi/versions'}
    payment_gateway_webhook { 'http://localhost:3000/ocpi/versions'}
    status_notification_webhook { 'http://localhost:3000/ocpi/versions'}
  end
end
