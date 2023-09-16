FactoryBot.define do
  factory :partner, class: 'Partner::Partner' do
    code { 'JMC' }
    name { 'Jom Charge' }
    address { "KLCC Area" }
    email      { Faker::Internet.email }
    password { "MyString123!" }
    password_confirmation { "MyString123!" }
    city { 'Kuala Lumpur' }
    state { 'Federal Territory of Kuala Lumpur' }
    confirmed_at { Time.current }
    postcode { '50088' }
    website_url { 'localhost:3000' }
    remember_created_at { Time.current }
    confirmation_sent_at { Time.current }
    mobile_phone { Faker::Base.numerify('+60197670###')} 
  end
end