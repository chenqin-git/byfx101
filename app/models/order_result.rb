class OrderResult < ApplicationRecord
  belongs_to :order

  def info
    if !success_num
      self.success_num = -1
    end

    if success_num < 0
      return "队列中"
    else
      @finish_rate = success_num * 100 / order.num
      return "[ #{operator} ][ #{@finish_rate}% ]：#{success_num} / #{order.num} | #{result} - #{message}"
    end
  end
end
