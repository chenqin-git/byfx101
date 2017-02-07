class Product < ApplicationRecord
  belongs_to :project
  has_many :orders
end
