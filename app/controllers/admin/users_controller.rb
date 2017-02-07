class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  def index
    @users = User.all
  end
end
