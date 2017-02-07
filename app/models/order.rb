class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  scope :recent, -> { order("created_at DESC") }
end
