class Product < ApplicationRecord
  belongs_to :project
  has_many :orders
  has_many :quotations

  def calculate_agent_price!(user)
    if !quotations || quotations.size == 0
      return -1
    else
      quotations.each do |q|
        if q.agent_rank == user.agent_rank
          return q.price
        end
      end

      return -1
    end
  end
end
