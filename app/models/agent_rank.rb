class AgentRank < ApplicationRecord
  has_many :quotations
  has_many :users
end
