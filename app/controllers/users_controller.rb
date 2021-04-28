class UsersController < ApplicationController
  include ApplicationHelper, SessionsHelper

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to billsplit"
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def edit
  end

  def show
    # byebug
    @user = current_user
    @bills = @user.bills
    

  end

  def destroy
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
