class Robot::StocksController < ApplicationController
  def synchronize
    @response = { success: false, message: "" }

    if !params.key?(:info) || params[:info].empty?
      @response[:message] = "参数 info 必须存在且有值"
    else
      @infos = params[:info].split(',')

      @infos.each do |info|
        @kvs = info.split(':')
        @product_id = @kvs[0].to_i
        @stock_num = @kvs[1].to_i

        @product = Product.find(@product_id)

        if !@product.stock
          @product.stock = Stock.new
          @product.stock.product = @product
        end

        @product.stock.num = @stock_num
        @product.stock.save
      end

      @response[:success] = true
      @response[:message] = "ok"
    end

    render json: @response
  end

end
