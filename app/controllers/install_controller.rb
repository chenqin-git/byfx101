class InstallController < ApplicationController
  def show
    @agent_ranks = AgentRank.all
    if @agent_ranks && @agent_ranks.size > 0
      #redirect_to root_path, alert: "系统已经初始化" and return
    end

    @user = User.new
  end

  def init
    # 创建默认用户等级
    @agent_ranks = AgentRank.all
    if !@agent_ranks || @agent_ranks.size == 0
      @agent_rank = AgentRank.new
      @agent_rank.rank = 1
      @agent_rank.name = "普通会员"
      @agent_rank.remark = "系统默认"
      @agent_rank.save
    end

    # 创建管理员

    redirect_to root_path, notice: "初始化成功！"
  end
end
