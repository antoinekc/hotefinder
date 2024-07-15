class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    report = MemoryProfiler.report do
      @users = User.includes(:avatar)

      if params[:categories].present?
        @users = @users.joins(:categories).where(categories: { id: params[:categories] }).distinct
      end

      if params[:cities].present?
        @users = @users.joins(:cities).where(cities: { id: params[:cities] }).distinct
      end

      @users = @users.page(params[:page]).per(10) # Use pagination to limit records loaded into memory

    end

    report.pretty_print(to_file: 'tmp/users_index_memory_report.txt')
  end

  def show
    @user = User.includes(:avatar).find(params[:id])
  end

  def edit
    @user = User.includes(:avatar).find(params[:id])
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
    flash[:notice] = 'L\'utilisateur a été supprimé'
    redirect_to users_url
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user || current_user.is_admin
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number, :birthdate, :commission, :description, :is_host, :is_owner, :is_available, :avatar, :email_notifications, city_ids: [], category_ids: [])
  end
end
