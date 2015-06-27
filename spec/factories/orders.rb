FactoryGirl.define do
  factory :order do
    user nil
    total { Faker::Commerce.price }
  end

end
