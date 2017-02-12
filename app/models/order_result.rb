class OrderResult < ApplicationRecord
  belongs_to :order

  def info
    if !success_num
      self.success_num = 0
    end

    if success_num == 0
      @str = "失败"
    elsif order
      @str = (success_num < order.num) ? "部分成功" : "成功"
    else
      @str = "未知错误"
    end

    "[#{operator}]：[#{result}]\t#{@str} - #{message}"
  end
end
