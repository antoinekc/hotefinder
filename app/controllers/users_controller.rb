class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @users = User.all
    # @users = User.includes(:cities).all
    # @locations = City.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Profil mis à jour'
      redirect_to @user
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user || current_user.is_admin
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number, :birthdate, :commission, :description, :is_host, :is_owner, :is_available, :avatar)
  end
end
