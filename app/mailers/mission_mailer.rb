class MissionMailer < ApplicationMailer
  def status_update(mission, user)
    @mission = mission
    @user = user
    if @user.email_notifications
      mail(to: @user.email, subject: "Mise à jour du statut de votre mission")
    end
  end

  def new_mission(mission, user)
    @mission = mission
    @user = user
    if @user.email_notifications
      mail(to: @user.email, subject: "Proposition de mission")
    end
  end
end
