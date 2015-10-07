FactoryGirl.define do
  factory :product do
    title { FFaker::Product.product_name }
    price { rand() * 100 }
    published false
    # instead of hardcoding user_id, if we just pass a user here
    # FactoryGirl will figure out what we're doing and create a new user 
    user
  end
end