class Account::OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    # 初始化查询界面
    @product_id = params[:product_id]
    @start_date = params.key?(:start_date) ? params[:start_date] : Date.today - 1
    @end_date = params.key?(:end_date) ? params[:end_date] : Date.today

    @is_search = params.key?(:search)

    if @is_search
      # 日期处理

      @orders = current_user.orders.query(@product_id, @start_date, @end_date).paginate(:page => params[:page], :per_page => 10)
    else
      @orders = current_user.orders.recent.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @order = Order.find(params[:id])

    if !current_user.orders.include?(@order)
      redirect_to root_path, alert: "你无权查看不属于自己的订单" and return
    end

    @account_books = AccountBook.where(order_id: @order.id)
  end
end
