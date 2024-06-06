class MissionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :create, :destroy]
  before_action :set_mission, only: %i[ show edit update destroy ]

  helper_method :paris_zip_codes

  # GET /missions or /missions.json
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

  # GET /missions/1 or /missions/1.json
  def show
    # Utilisez simplement @mission tel qu'il est
  end

  # GET /missions/new
  def new
    @mission = Mission.new
    @user = User.find(params[:host_id]) if params[:host_id].present? # Suppose que vous passez l'id de l'host dans les paramètres
  end

  # GET /missions/1/edit
  def edit
    # Utilisez simplement @mission tel qu'il est
  end

  # POST /missions or /missions.json
  def create
    @mission = Mission.new(mission_params)
    @mission.owner = current_user # Assurez-vous que l'utilisateur connecté est le propriétaire de la mission

    # Récupérer l'utilisateur (host) à partir de params
    if params[:mission][:host_id].present?
    @user = User.find(params[:mission][:host_id])
    
    # Assurez-vous que l'utilisateur (host) est correctement défini avant de l'assigner à la mission
    if @user
      @mission.host = @user
    else
      # Gérer le cas où l'utilisateur (host) n'est pas trouvé
      # Vous pouvez afficher un message d'erreur ou rediriger vers une autre page
      redirect_to root_path, alert: "Host not found"
      return
    end
  end

    # Récupérer ou créer un objet City correspondant au nom de la ville fourni
    city_name = params[:mission].delete(:city) # Supprimer la clé :city des paramètres de mission
    city = City.find_or_create_by(name: city_name)
    @mission.city = city

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

  # PATCH/PUT /missions/1 or /missions/1.json
  def update
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

  # DELETE /missions/1 or /missions/1.json
  def destroy
    @mission.destroy!

    respond_to do |format|
      format.html { redirect_to missions_url, notice: "Mission was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission
      @mission = Mission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mission_params
      params.require(:mission).permit(:title, :description, :start_date, :end_date, :city_name, :postal_code, :city_id, :host_id)
    end
end
