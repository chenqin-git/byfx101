class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def new
    self.num = 1
    self.input = "输入参数"
  end
end
