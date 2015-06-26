FactoryGirl.define do
  factory :product do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    published false
    user_id 1
  end

end
