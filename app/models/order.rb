class Order < ApplicationRecord
  validates :num, format: { with: /\d+/, message: "必须是数字" }

  belongs_to :product
  belongs_to :user

  scope :recent, -> { order("created_at DESC") }

  def calculate_amount!
    @price = product.calculate_agent_price!(user)

    if !@price || @price == -1
      return -1
    elsif !num
      return 0
    else
      return @price * num
    end
  end
end
