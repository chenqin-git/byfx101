class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :find_project_and_check_permission, only: [:edit, :update, :destroy]

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
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
  end

  def destroy

  end

  private

  def find_project_and_check_permission
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :remark)
  end
end
