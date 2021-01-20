class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :product_name
    validates :description_of_item
    validates :price
  end

  validates_inclusion_of :price, in: 300..9_999_999
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width number' }

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id
    validates :product_condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  belongs_to :user
  has_one    :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship
end
