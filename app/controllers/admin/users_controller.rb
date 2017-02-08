class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :check_permission!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new_configure
    @user = User.find(params[:id])
    @agent_ranks = AgentRank.all
    @projects = Project.all
  end

  def configure
    @user = User.find(params[:id])
    @fu = user_config_params

    if @user.update(user_config_params)
      @user.joined_projects << Project.find(params[:user]["joined_project_ids"][1])
      if @user.save
        redirect_to admin_users_path, notice: "配置成功！"
      else
        render :new_configure
      end
    else
      render :new_configure
    end
  end

  private

  def user_config_params
    params.require(:user).permit(:agent_rank_id, :joined_project_ids)
  end
end
