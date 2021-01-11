class Item < ApplicationRecord
  with_options presence: true do
    validates :product_name
    validates :description_of_item
    validates :image
  end

  with_options presence: true format: { with: /\A[0-9]+\z/, message: 'には半角数字を使用してください' } do
    validates :price, numericality: true { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :product_condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship
end
