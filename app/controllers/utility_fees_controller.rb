class UtilityFeesController < ApplicationController

  def index
    @utility_fees = UtilityFee.paginate(page: params[:page])
  end

  def new
    @utility_fee = UtilityFee.new
  end

  def create
    @utility_fee = UtilityFee.new(fee_params)
      if @utility_fee.save
        flash[:success] = "Utility Fee saved."
        redirect_to utility_fees_path
      else
        render 'new'
      end
  end

  def show
    @utility_fee = UtilityFee.find(params[:id])
  end

  def edit
    @utility_fee = UtilityFee.find(params[:id])
  end

  def update
    @utility_fee = UtilityFee.find(params[:id])
      if @utility_fee.update_attributes(fee_params)
        flash[:success] = "Utility Fee details updated."
        redirect_to @utility_fee
      else
        render 'edit'
      end
  end

  private

    def fee_params
      params.require(:utility_fee).permit(:name, :amount, :description)
    end
end
