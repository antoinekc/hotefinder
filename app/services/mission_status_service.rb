class MissionStatusService

  INITIAL_STATUS = 'Créée'.freeze
  
  STATUSES = [
    'Créée',
    'Soumise',
    'Acceptée',
    'Annulée',
    'En cours',
    'Terminée',
    'Refusée',
    'Non-effectuée',
    'Deleted'
  ].freeze

  def initialize(user, mission)
    @user = user
    @mission = mission
  end

  def owner_permissions
    case @mission.status
    when 'Créée'
      ['Créée','Soumise']
    when 'Soumise'
      ['Annulée']
    when 'Acceptée'
      ['En cours', 'Annulée']
    when 'En cours'
      ['Terminée', 'Annulée']
    else
      []
    end
  end

  def host_permissions
    case @mission.status
    when 'Soumise'
      ['Acceptée', 'Refusée']
    when 'Acceptée'
      ['En cours']
    when 'En cours'
      ['Terminée']
    else
      []
    end
  end

  def allowed_statuses
    if @user.is_owner
      owner_permissions
    elsif @user.is_host
      host_permissions
    end
  end
end