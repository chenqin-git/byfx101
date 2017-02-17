class InstallController < ApplicationController
  def show
    @agent_ranks = AgentRank.all
    @admin = User.find_by(id: 1)

    if @agent_ranks && @agent_ranks.size > 0 && @admin
      redirect_to root_path, alert: "系统已经初始化，不用重复操作" and return
    end

    @user = User.new
  end

  def init
    # 校验
    if params[:user][:email].empty?
      redirect_to install_path, alert: "email 不能为空" and return
    end

    if params[:user][:password] != params[:user][:password_confirmation]
      redirect_to install_path, alert: "确认密码不一致" and return
    end

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
    @admin = User.find_by(id: 1)
    if !@admin
      User.create!(:email => params[:user][:email], :password => params[:user][:password])
      redirect_to root_path, notice: "初始化成功！"
    else
      redirect_to root_path, alert: "已经初始化，不用重复操作"
    end
  end
end
