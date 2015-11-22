class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render 'home'
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to TrafficLess!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def entries
    render 'entries'
  end

  def addErrands
  end

  def profile
    @user = User.find(params[:id])
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
