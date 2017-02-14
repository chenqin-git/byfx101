class Admin::QuotationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :check_permission!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @quotations = Quotation.all

  end

  def new
    @quotation = Quotation.new

    if params[:product_id] #当在产品信息中设置价格表则产品参数存在
      @quotation.product = Product.find(params[:product_id])
    end
  end

  def create
    @quotation = Quotation.new(quotation_params)

    # 校验是否存在相同记录
    @sames = Quotation.where("product_id = ? and agent_rank_id = ?",
      quotation_params[:product_id],
      quotation_params[:agent_rank_id])

    if @sames && @sames.size > 0
      flash[:alert] = "已经存在相同记录，产品和用户等级是唯一对应的，请修改后重试"
      render :new and return
    end

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

    # 校验是否存在相同记录
    @sames = Quotation.where("product_id = ? and agent_rank_id = ? and id <> ?",
      quotation_params[:product_id],
      quotation_params[:agent_rank_id],
      params[:id])

    if @sames && @sames.size > 0
      flash[:alert] = "已经存在相同记录，产品和用户等级是唯一对应的，请修改后重试"
      render :edit and return
    end

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

  def check_exists
    @quotations = Quotation.where(product_id: params[:product_id], agent_rank_id: params[:agent_rank_id])
    return @quotations && @quotations.size > 0
  end
end
