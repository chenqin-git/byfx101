module Admin::OrdersHelper
  def show_result(order)
    if order.order_result
      simple_format(order.order_result.info)
    else
      "无结果"
    end
  end
end
