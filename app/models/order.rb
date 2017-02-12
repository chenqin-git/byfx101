class Order < ApplicationRecord
  validates :num, format: { with: /\d+/, message: "必须是数字" }

  belongs_to :product
  belongs_to :user
  has_one :order_result
  accepts_nested_attributes_for :order_result, :reject_if => :all_blank

  scope :recent, -> { order("created_at DESC") }

  def calculate_amount!
    @price = product.calculate_agent_price!(user)

    if !@price || @price  == -1
      return -1
    elsif !num
      return 0
    else
      return @price * num
    end
  end

  def status
    case state
    when 0
      order_result ? "已处理" : "等待处理"
    when 1
      return "取消"
    else
      return "未知"
    end
  end

  def show_result
    order_result ? order_result.info : "无结果"
  end
end
