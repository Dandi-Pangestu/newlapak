FactoryBot.define do
  factory :product, class: 'Product' do
    name { Faker::Name.name }
    price { Faker::Number.number(5) }
    stock { Faker::Number.number(2) }
  end
end
