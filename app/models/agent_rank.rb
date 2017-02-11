class AgentRank < ApplicationRecord
  has_many :quotations, dependent: :delete_all
  has_many :users, dependent: :nullify
end
