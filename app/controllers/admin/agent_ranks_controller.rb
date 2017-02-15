class Admin::AgentRanksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :check_permission!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @agent_ranks = AgentRank.all
  end

  def new
    @agent_rank = AgentRank.new
  end

  def create
    @agent_rank = AgentRank.new(agent_rank_params)

    if @agent_rank.save
      redirect_to admin_agent_ranks_path
    else
      render :new
    end
  end

  def edit
    @agent_rank = AgentRank.find(params[:id])
  end

  def update
    @agent_rank = AgentRank.find(params[:id])
    if @agent_rank.update(agent_rank_params)
      redirect_to admin_agent_ranks_path
    else
      render :edit
    end
  end

  def destroy
    if params[:id] == 1
      redirect_to admin_agent_ranks_path, alert: "默认用户等级不能删除" and return
    end

    @agent_rank = AgentRank.find(params[:id])
    if @agent_rank.destroy
      redirect_to admin_agent_ranks_path, alert: "用户等级成功删除！"
    else
      redirect_to admin_agent_ranks_path, alert: "用户等级删除失败，请查看相关日志检查原因！"
    end
  end

  private

  def agent_rank_params
    params.require(:agent_rank).permit(:name, :rank, :remark)
  end

end
