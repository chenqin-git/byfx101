class Admin::QuotationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :check_permission!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @quotations = Quotation.all

  end

  def new
    @quotation = Quotation.new
    @products = Product.all
    @agent_ranks = AgentRank.all
  end

  def create
    @quotation = Quotation.new(quotation_params)

    if @quotation.save
      redirect_to admin_quotations_path, notice: "创建成功！"
    else
      render :new
    end
  end

  def edit
    @quotation = Quotation.find(params[:id])
  end

  def update
    @quotation = Quotation.find(params[:id])

    if @quotation.update(quotation_params)
      redirect_to admin_quotations_path, notice: "更新成功！"
    else
      render :edit
    end
  end

  def destroy
    @quotation = Quotation.find(params[:id])

    @quotation.destroy
    redirect_to admin_quotations_path
  end

  private

  def quotation_params
    params.require(:quotation).permit(:price, :product_id, :agent_rank_id)
  end
end
