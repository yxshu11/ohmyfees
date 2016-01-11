class UtilityFeesController < ApplicationController

  def new
    @u_fee = UtilityFee.new
  end

  def create
    @u_fee = UtilityFee.new
  end

  def show
    @u_fee = UtilityFee.find(params[:id])
  end

  def index
    @u_fee = UtilityFee.paginate(page: params[:page])
  end

end
