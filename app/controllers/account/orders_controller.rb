class Account::OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @orders = current_user.orders.recent.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @order = Order.find(params[:id])

    if !current_user.orders.include?(@order)
      redirect_to root_path, alert: "你无权查看不属于自己的订单" and return
    end

    @account_books = AccountBook.where(order_id: @order.id)
  end
end
