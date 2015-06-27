FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "Xyston Product #{n}" }
    price { rand() * 100 }
    published false
    user
  end

end
