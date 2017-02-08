class Quotation < ApplicationRecord
  belongs_to :product
  belongs_to :agent_rank
end
