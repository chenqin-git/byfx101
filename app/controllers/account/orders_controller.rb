class Account::OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])

    if !@order
      redirect_to root_path, alert: "订单不存在"
    elsif !current_user.orders.include?(@order)
      redirect_to root_path, alert: "你无权查看不属于自己的订单"
    end
  end
end
