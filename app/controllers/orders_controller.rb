class OrdersController < ApplicationController
  def index

  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
    @order.product = @product
  end

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(order_params)
    @order.product = @product
    @order.user = current_user

    @order_result = OrderResult.new(success_num: -1)
    @order_result.order = @order
    @order.order_result = @order_result

    if @product.calculate_agent_price!(current_user) <= 0
      redirect_to project_path(@product.project), notice: "你的等级无权购买此商品"
      return
    end

    if @order.save
      redirect_to project_path(@product.project)
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:num, :input)
  end
end
