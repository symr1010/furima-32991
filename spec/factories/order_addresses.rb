FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    municipality { '東京都' }
    address { '1-1' }
    phone_number { '00011112222' }
  end
end
