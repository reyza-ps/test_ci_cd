FactoryBot.define do
  factory :oauth_access_grant, class: 'Partner::AccessGrant' do
    token { "986ErEOtAlPa8TBDKPrleqF0fz2ctQsITXVk2xQ-aLo" }
    expires_in { 3600 }
    redirect_uri { "http://evpartnertest.com/" }
    scopes { ["write", "update", "read", "delete"] }
  end
end
