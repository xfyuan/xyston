FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "Xyston #{n}" }
    price { rand() * 100 }
    published false
    user
  end

end
