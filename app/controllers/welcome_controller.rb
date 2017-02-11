class WelcomeController < ApplicationController
  def index
    flash[:notice] = "早安！你好！"

  end

  def show
    @user = User.last

    render json: Order.all
    #render body: "<b>aaa</b>"
    #render plain: "OK"
    #render html: "<strong>Not Found</strong>".html_safe
    #head :bad_request
  end
end
