class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]

  def index
    @orders = Order.all.recent.paginate(:page => params[:page], :per_page => 10)
  end

  def show

  end
end
