class SessionsController < ApplicationController
  include ApplicationHelper, SessionsHelper

  def new
    render :new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
		
		if @user && @user.authenticate(params[:user][:password])
			log_in(@user)	
      # byebug		
			flash[:notice] = "Successfully logged in."
			redirect_to user_url(@user)
		else
			flash.now[:danger] = 'Invalid email/password combination'
			render :new
		end
  end

  def destroy
    logout_user
		flash[:notice] = "Successful logout."
		redirect_to new_session_url
  end
end
