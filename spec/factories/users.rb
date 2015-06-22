FactoryGirl.define do
  factory :user do
    name                 { Faker::Internet.user_name('testuser') }
    email                { Faker::Internet.email('testuser') }
    password             { Faker::Internet.password(14) }
    authentication_token { Faker::Internet.password(14) }
    firstname            { Faker::Name.first_name }
    lastname             { Faker::Name.last_name }
    admin false
  end

end
