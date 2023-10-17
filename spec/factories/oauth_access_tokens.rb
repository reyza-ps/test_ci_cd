FactoryBot.define do
  factory :oauth_access_token, class: 'Partner::AccessToken' do
    token { '986ErEOtAlPa8TBDKPrleqF0fz2ctQsITXVk2xQ-aLo' }
    refresh_token { 'Qp11D04YHc0FOYxUIHkf0B-cDHEMvIJOUovUzYf2Pzg' }
    scopes { %w[write update read delete] }
    oauth_access_grant_id { 1 }
    # ocpi_credential
  end
end
