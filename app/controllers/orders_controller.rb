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
      redirect_to project_path(@product.project), alert: "你的等级无权购买此商品"
      return
    end

    @stock_num = @product.stock_num!
    if @order.num > @stock_num
      flash[:warning] = "当前库存（#{@stock_num}）不足，无法购买 #{@order.num} 个，请刷新库存重试"
      render :new and return
    end

    @order_amount = @order.calculate_amount!
    @balance = current_user.balance!
    if @order_amount > @balance
      flash[:warning] = "你的余额（#{@balance}）不足，无法购买此商品（#{@order_amount}）"
      render :new and return
    end

    if @order.save
      # 更新账本记录
      @account_book = AccountBook.new
      @account_book.user = current_user
      @account_book.order_id = @order.id
      @account_book.amount = @order_amount * -1
      @account_book.transaction_type = 2
      @account_book.balance = @balance - @order_amount
      @account_book.operator = current_user.email
      @account_book.remark = "购买 #{@product.name} * #{@order.num}"
      @account_book.save

      # 更新缓存库存记录
      if @product.stock
        @product.stock.num -= @order.num
        @product.stock.save
      end

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
