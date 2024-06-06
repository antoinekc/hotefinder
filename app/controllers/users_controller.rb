class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user || current_user.is_admin
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number, :birthdate, :commission, :is_host, :is_owner, :is_available, :avatar)
  end
end
