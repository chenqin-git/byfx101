class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]
  before_action :check_permission!, only: [:index]

  def index
    @orders = Order.all.recent.paginate(:page => params[:page], :per_page => 10)
  end

  def show

  end

  def search
    @product = Product.find(params[:product_id])
    @orders = Order.where(product: @product).recent.paginate(:page => params[:page], :per_page => 100)

    @total_amount = 0
    @total_num = 0

    @orders.each do |o|
      @total_amount += o.calculate_amount!
      @total_num += o.num ? o.num : 0
    end
  end

  def set_result
    @order = Order.find(params[:id])

    if !@order.order_result
      @order_result = OrderResult.new
      @order_result.operator = current_user.email
      @order_result.success_num = @order.num
      @order_result.message = "管理后台手动设置"
    else
      @order_result = @order.order_result
    end
  end

  def save_result
    @order = Order.find(params[:id])

    if @order.order_result
      if @order.order_result.update(order_result_params)
        redirect_to admin_orders_path
      else
        render :set_result
      end
    else
      @order_result = OrderResult.new(order_result_params)
      @order_result.order = @order

      if @order_result.save
        redirect_to admin_orders_path, notice: "创建订单结果成功"
      else
        render :fill_result
      end
    end
  end

  private

  def order_result_params
    params.require(:order_result).permit(:result, :success_num, :message, :operator)
  end
end
