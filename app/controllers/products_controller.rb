class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @project = Project.find(params[:project_id])
    @product = Product.new
  end

  def create
    @project = Project.find(params[:project_id])
    @product = Product.new(product_params)
    @product.project = @project

    if @product.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to project_path(@product.project)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to project_path(@product.project)
  end

  private

  def product_params
    params.require(:product).permit(:name, :remark)
  end
end
