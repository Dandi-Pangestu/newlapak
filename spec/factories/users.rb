FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::Name.name }
    email { Faker::Email.email }
    password { Faker::Alphanumeric.alpha(10) }
  end
end
