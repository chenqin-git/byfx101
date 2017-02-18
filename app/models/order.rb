class Order < ApplicationRecord
  validates :num, presence: true
  belongs_to :product
  belongs_to :user
  has_one :order_result
  accepts_nested_attributes_for :order_result

  scope :recent, -> { order("created_at DESC") }
  scope :query, ->(product_id, start_date, end_date) {
    where("(product_id == ? or -1 == ?) and (created_at >= ? or '' == ?) and (created_at <= ? or '' == ?)",
      product_id, product_id,
      start_date, start_date,
      end_date, end_date)
  }

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

  def calculate_refund!
    if !order_result || !order_result.success_num
      return 0
    end

    @price = product.calculate_agent_price!(user)
    if !@price || @price <= 0
      return 0
    end

    @refund = (num - order_result.success_num) * @price
    if @refund > calculate_amount!
      return 0
    end

    return @refund
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
