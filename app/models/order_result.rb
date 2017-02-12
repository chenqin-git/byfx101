class OrderResult < ApplicationRecord
  belongs_to :order

  def info
    @str = success ? "成功" : "失败"
    "[#{operator}]：[#{result}]\t#{@str} - #{message}"
  end
end
