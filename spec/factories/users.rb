FactoryGirl.define do
  factory :user do
    name                 { Faker::Internet.user_name }
    email                { Faker::Internet.email }
    password             { Faker::Internet.password }
    authentication_token { Faker::Internet.password }
    firstname            { Faker::Name.first_name }
    lastname             { Faker::Name.last_name }
    admin false
  end

end
