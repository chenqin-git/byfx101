class Product < ApplicationRecord
  belongs_to :project
  has_many :orders, dependent: :restrict_with_error
  has_many :quotations, dependent: :delete_all
  has_one :stock, dependent: :destroy

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

  def stock_num!
    stock && stock.num ? stock.num : 0
  end
end
