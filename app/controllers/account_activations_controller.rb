class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      session[:modal] = true
      #redirect_to user
      redirect_to '/users/' + user.id.to_s + '/pretest'
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
