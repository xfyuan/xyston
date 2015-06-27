FactoryGirl.define do
  factory :user do
    sequence(:name)      { |n| "xyston#{n}" }
    sequence(:email)     { |n| "xyston#{n}@abc.com" }
    password             'nopassword123'
    password_confirmation 'nopassword123'
    sequence(:firstname) { |n| "Apple#{n}" }
    sequence(:lastname)  { |n| "Tree#{n}" }
    admin false
  end

end
