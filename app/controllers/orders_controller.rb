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
