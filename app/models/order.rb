class Order < ApplicationRecord
  validates :num, format: { with: /\d+/, message: "必须是数字" }

  belongs_to :product
  belongs_to :user
  has_one :order_result
  accepts_nested_attributes_for :order_result

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
      if order_result
        if !order_result.success_num
          order_result.success_num = -1
        end

        if order_result.success_num  < 0
          return "等待处理"
        elsif order_result.success_num == 0
          return "全部失败"
        elsif order_result.success_num < num
          return "部分成功"
        else
          return "全部成功"
        end
      else
        return "无效数据"
      end
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
