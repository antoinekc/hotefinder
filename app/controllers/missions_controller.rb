class MissionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :create, :destroy]
  before_action :set_mission, only: %i[show edit update destroy]

  helper_method :paris_zip_codes

  def index
    if current_user.is_owner
      @missions = current_user.sent_missions
    elsif current_user.is_host
      @missions = current_user.received_missions
    else
      redirect_to root_path, alert: "Vous devez vous inscrire pour voir cette page."
    end
  end

  def show
    @mission = Mission.find(params[:id])
    @categories = @mission.categories
  end

  def new
    @mission = Mission.new
    @user = params[:host_id].present? ? User.find(params[:host_id]) : nil
    @mission.status = ""
    @mission.city_id = 1
  end

  def edit
    @mission = Mission.find(params[:id])
    @categories = @mission.categories
  end

  def create
    @mission = Mission.new(mission_params)
    @mission.owner = current_user
    @mission.status = "En attente"

    if params[:mission][:host_id].present?
      @user = User.find(params[:mission][:host_id])


      if @user
        @mission.host = @user
      else
        redirect_to root_path, alert: "Veuillez indiquer un concierge."
        return
      end
    end

    if @mission.save
      MissionMailer.new_mission(@mission, @mission.host).deliver_later if @mission.host.email_notifications
      redirect_to mission_url(@mission), notice: "La mission a été créée avec succès."
    else
      flash[:alert] = "Une erreur est apparue lors de la création de mission."
      render :new, status: :unprocessable_entity
    end
  end

  def paris_zip_codes
    (75001..75020).map { |zip_code| [zip_code.to_i, zip_code] }
  end

  def update
    previous_status = @mission.status

    case params[:choix]
    when "Accepter mission"
      @mission.status = "Acceptée"
    when "Refuser mission"
      @mission.status = "Refusée"
    when "Abandonner mission"
      @mission.status = "Abandonnée"
    when "Annuler mission"
      @mission.status = "Annulée"
    when "Démarrer mission"
      @mission.status = "En cours"
    when "Terminer mission"
      @mission.status = "Terminée"
    end

    if params[:mission].present?
      # Regular update with mission parameters
      if @mission.update(mission_params)
        send_status_update_emails if @mission.status != previous_status
        redirect_to mission_url(@mission), notice: "La mission a été mise à jour."
      else
        flash[:alert] = "Une erreur est apparue lors de la mise à jour de la mission."
        render :edit, status: :unprocessable_entity
      end
    else
      # Update only the status
      if @mission.save
        send_status_update_emails if @mission.status != previous_status
        redirect_to mission_url(@mission), notice: "Le statut de la mission a été mis à jour."
      else
        flash[:alert] = "Une erreur est apparue lors de la mise à jour de la mission."
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @mission.destroy
    redirect_to missions_url, notice: "La mission a été détruite avec succès."
  end

  private

  def set_mission
    @mission = Mission.find(params[:id])
    @city = @mission.city
  end

  def mission_params
    params.require(:mission).permit(:title, :description, :start_date, :end_date, :postal_code, :city_id, :host_id, :status, category_ids: [])
  end

  def send_status_update_emails
    MissionMailer.status_update(@mission, @mission.owner).deliver_later if @mission.owner.email_notifications
    MissionMailer.status_update(@mission, @mission.host).deliver_later if @mission.host.email_notifications
  end
end
