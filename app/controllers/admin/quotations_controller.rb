class Admin::QuotationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  #before_action :check_permission, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @quotations = Quotation.all

  end

  def new
    @quotation = Quotation.new
    @products = Product.all
    @agent_ranks = AgentRank.all
  end

  def create

  end
end
