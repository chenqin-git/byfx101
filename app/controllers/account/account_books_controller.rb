class Account::AccountBooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @account_books = current_user.account_books.recent.paginate(:page => params[:page], :per_page => 10)
  end
end
