class QuotationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @quotations = Quotation.all
  end

  def new
    @products = Product.all
    @agent_ranks = AgentRank.all
    @quotation = Quotation.new
  end 
end
