class Admin::ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :find_project_and_check_permission, only: [:edit, :update, :destroy]
  before_action :check_permission!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def edit

  end

  def show
    @project = Project.find(params[:id])
    @products = @project.products
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to admin_projects_path
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to admin_projects_path
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to admin_projects_path, alert: "项目成功删除！"
    else
      redirect_to admin_projects_path, alert: "项目删除失败，请查看相关日志检查原因！"
    end
  end

  private

  def find_project_and_check_permission
    @project = Project.find(params[:id])

    if @project.user != current_user
      redirect_to root_path, alert: "你没有权限进行此项操作！"
    end
  end

  def project_params
    params.require(:project).permit(:name, :remark)
  end
end
