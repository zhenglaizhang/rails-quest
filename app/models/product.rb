class Product < ApplicationRecord
  # standard rails validator
  # todo RE refresh

  validates :title, :description, :image_url, presence: true
  # price is at least 1 cent, as db only store 2 digits after decimal point
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)\Z}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
