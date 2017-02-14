class AccountBook < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order("created_at DESC") }

  def show_transaction_type!
    if transaction_type == 1
      "充值"
    elsif transaction_type == 2
      "消费"
    elsif transaction_type == 3
      "退款"
    else
      "未知"
    end
  end

  def calculate_balance!
    balance = user.balance! + amount
  end
end
