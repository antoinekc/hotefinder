class MissionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :create, :destroy]
  before_action :set_mission, only: %i[show edit update destroy]

  helper_method :paris_zip_codes

  def index
    if current_user.is_owner
      # En tant que propriétaire, récupérer les missions proposées aux concierges (hosts)
      @missions = current_user.sent_missions
    elsif current_user.is_host
      # En tant que concierge, récupérer les missions qui lui ont été proposées
      @missions = current_user.received_missions
    else
      # Gérer le cas où l'utilisateur n'est ni propriétaire ni concierge
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  end

  def show
  end

  def new
    @mission = Mission.new
    if params[:host_id].present?
      @user = User.find(params[:host_id])
    else
      @user = nil
    end
    @mission.status = ""
  end

  def edit
    @mission = Mission.find(params[:id])
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
        redirect_to root_path, alert: "Host not found"
        return
      end
    end

    respond_to do |format|
      if @mission.save
        format.html { redirect_to mission_url(@mission), notice: "Mission was successfully created." }
        format.json { render :show, status: :created, location: @mission }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  def paris_zip_codes
    (75001..75020).map { |zip_code| [zip_code.to_i, zip_code] }
  end

  def update
    Rails.logger.debug "Params reçus : #{params.inspect}"
    the_choice
    Rails.logger.debug "Mission status après the_choice : #{@mission.status}"
  

    respond_to do |format|
      if @mission.update(mission_params)
        format.html { redirect_to mission_url(@mission), notice: "Mission was successfully updated." }
        format.json { render :show, status: :ok, location: @mission }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mission.destroy!

    respond_to do |format|
      format.html { redirect_to missions_url, notice: "Mission was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_mission
      @mission = Mission.find(params[:id])
    end

    def mission_params
      params.require(:mission).permit(:title, :description, :start_date, :end_date, :postal_code, :city_id, :host_id, :status)
    end

    def the_choice
      Rails.logger.debug "Choix reçu : #{params[:choix]}"
      case params[:choix]
      when "Accepter Mission"
        @mission.status = "Acceptée"
      when "Refuser Mission"
        @mission.status = "Refusée"
      when "Abandonner mission"
        @mission.status = "Abandonnée"
      when "Annuler Mission"
        @mission.status = "Annulée"
      end
       Rails.logger.debug "Mission status dans the_choice : #{@mission.status}"
    end
end
