class UtilityFeesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  before_action :correct_user_type, only: [:new, :create, :show, :index, :edit, :update, :destroy]

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

  def destroy
    @utility_fee = UtilityFee.find(params[:id]).destroy
    flash[:success] = "Select utility fee deleted."
    redirect_to utility_fees_path
  end

  private

    def fee_params
      params.require(:utility_fee).permit(:name, :amount, :description)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def correct_user_type
      unless @current_user.type == "Staff"
        flash[:danger] = "Access Denied."
        redirect_to(root_path)
      end
    end
end
