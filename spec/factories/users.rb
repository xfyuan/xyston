FactoryGirl.define do
  factory :user do
    name                 { Faker::Internet.user_name('testuser') }
    email                { Faker::Internet.email('user') }
    password             'nopassword123'
    password_confirmation 'nopassword123'
    firstname            { Faker::Name.first_name }
    lastname             { Faker::Name.last_name }
    admin false
  end

end
