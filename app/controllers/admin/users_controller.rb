class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :check_permission!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 20)
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

  def new_deposit
    @user = User.find(params[:id])
    @account_books = @user.account_books.recent.paginate(:page => params[:page], :per_page => 10)
    @account_book = @user.account_books.build
  end

  def deposit
    @user = User.find(params[:id])

    @account_book = AccountBook.new(account_book_params)
    @account_book.user = @user
    @account_book.amount = account_book_params[:amount]
    @account_book.transaction_type = 1 #1-充值 2-消费
    @account_book.balance = @user.balance! + @account_book.amount
    @account_book.order_id = 0
    @account_book.operator = current_user.email

    if @account_book.save
      redirect_to admin_users_path, notice: "充值成功！"
    else
      render :new_deposit
    end
  end

  private

  def user_config_params
    params.require(:user).permit(:agent_rank_id, :joined_project_ids)
  end

  def account_book_params
    params.require(:account_book).permit(:amount, :deposit_reference_no, :remark)
  end
end
