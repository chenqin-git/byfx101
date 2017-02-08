class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_permission!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def new
    @project = Project.find(params[:project_id])
    @product = Product.new
  end

  def create
    @project = Project.find(params[:project_id])
    @product = Product.new(product_params)
    @product.project = @project

    if @product.save
      redirect_to admin_project_path(@project)
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_project_path(@product.project)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_project_path(@product.project)
  end

  private

  def product_params
    params.require(:product).permit(:name, :input_name, :remark)
  end
end
