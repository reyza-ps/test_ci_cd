# frozen_string_literal: true

FactoryBot.define do
  factory :api_request_log, class: 'Partner::ApiRequestLog' do
    description         { 'OCPI API outgoing request PATCH' }
    endpoint            { 'https://localhost:3000' }
    environment         { 'test' }
    http_method         { 'PATCH' }
    request_type        { 'outgoing' }
    request_headers     do
      {
        'User-Agent' => 'Faraday v2.3.0',
        'Content-Type' => 'application/json',
        'X-Request-ID' => '54224b13-7f0d-491a-a0a0-d0589cc26189',
        'Authorization' => 'Token OTNmOTY4ODItY2Q3Zi00OGRjLTljZjgtOTQ4Mjg4YjAyOGU2',
        'X-Correlation-ID' => 'e17cd063-16ac-46be-b896-86fc793f3d49'
      }
    end
    #  request_params       :jsonb
    #  request_type         :integer
    #  response_body        :jsonb
    #  status_code          :string
    #  created_at           :datetime         not null
    #  updated_at           :datetime         not null
    #  oauth_application_id :bigint
  end
end
