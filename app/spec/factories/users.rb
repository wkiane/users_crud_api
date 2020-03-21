FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.unique.first_name }
    last_name { FFaker::Name.unique.last_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end