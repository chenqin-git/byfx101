class Quotation < ApplicationRecord
  validates :price, presence: true

  belongs_to :product
  belongs_to :agent_rank
end
