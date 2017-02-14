class Robot::OrdersController < ApplicationController
  def queue
    @order = Order.find_by_sql("SELECT orders.* FROM orders
    LEFT JOIN order_results ON orders.id = order_results.order_id
    where orders.state = 0 and (order_results.success_num = -1 or order_results.success_num is null)
    ORDER BY orders.id ASC
    limit 1")

    render json: @order
  end

  def done
    @response = { success: false, message: "" }

    if !params.key?(:id) || params[:id] !~ /^\d+$/
      @response[:message] = "参数 id 必须存在且为数字"
    elsif !params.key?(:success_num) || params[:success_num] !~ /^\d+$/
      @response[:message] = "参数 success_num 必须存在且为正整数"
    elsif !params.key?(:result) || params[:result].empty?
      @response[:message] = "参数 result 必须存在且有值"
    elsif !params.key?(:message)
      @response[:message] = "参数 message 必须存在"
    elsif !params.key?(:operator) || params[:operator].empty?
      @response[:operator] = "参数 operator 必须存在且有值"
    else
      @order = Order.find_by(id: params[:id])
      if !@order
        @response[:message] = "异常数据：找不到 id=#{params[:id]} 的订单信息"
      elsif @order.state > 0
        @response[:message] = "违反约束：id=#{params[:id]} 的订单状态不可操作"
      elsif @order.num  < params[:success_num].to_i
        @response[:message] = "逻辑错误：success_num 不可能大于 num"
      elsif !@order.order_result
        @response[:message] = "无效数据：找不到 id=#{params[:id]} 的订单结果信息"
      elsif @order.order_result.success_num >= 0
        @response[:message] = "逻辑错误：id=#{params[:id]} 的订单结果已经被处理过"
      else
        if @order.order_result.update(params.permit(:success_num, :result, :message, :operator))
          @response[:success] = true
          @response[:message] = "ok"

          # 退款逻辑
          @refund = @order.calculate_refund!
          if @refund != 0
            @account_book = AccountBook.new
            @account_book.user = @order.user
            @account_book.amount = @refund
            @account_book.transaction_type = 3
            @account_book.order_id = @order.id
            @account_book.operator = params[:operator]
            @account_book.remark = "订购 #{@order.product.name} * #{@order.num}，成功 #{params[:success_num]} 个"
            @account_book.balance = @account_book.calculate_balance!
            @account_book.save
          end
        else
          @response[:message] = "保存 id=#{params[:id]} 的订单的操作结果失败"
        end
      end
    end

    render json: @response
  end
end
