class ProgrammesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :staff_user_type, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  def index
    @programmes = Programme.paginate(page: params[:page])
  end

  def new
    @programme = Programme.new
  end

  def create
    @programme = Programme.new(programme_params)
      if @programme.save
        flash[:success] = "Programme Saved!"
        redirect_to @programme
      else
        render 'new'
      end
  end

  def show
    @programme = Programme.find(params[:id])
  end

  def edit
    @programme = Programme.find(params[:id])
  end

  def update
    @programme = Programme.find(params[:id])
      if @programme.update_attributes(programme_params)
        flash[:success] = "Programme Details Updated!"
        redirect_to @programme
      else
        render 'edit'
      end
  end

  def destroy
    Programme.find(params[:id]).destroy
    flash[:success] = "Programme Deleted"
    redirect_to programmes_path
  end

  private

    def programme_params
      params.require(:programme).permit(:programme_type, :name, :description)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def staff_user_type
      unless @current_user.type == "Staff"
        flash[:danger] = "Access Denied."
        redirect_to(root_path)
      end
    end

end
