class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :check_permission!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new_configure
    @user = User.find(params[:id])
  end

  def configure
    @user = User.find(params[:id])

    @user.agent_rank_id = params[:user]["agent_rank_id"].to_i
    @user.joined_projects = []

    @jpids = params[:user]["joined_project_ids"]
    @jpids.each do |ids|
      if ids && ids != ""
        @user.joined_projects << Project.find(ids.to_i)
      end
    end

    if @user.save
      redirect_to admin_users_path, notice: "配置成功！"
    else
      render :new_configure
    end
  end

  private

  def user_config_params
    params.require(:user).permit(:agent_rank_id, :joined_project_ids)
  end
end
