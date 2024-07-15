class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :cities
  has_many :sent_missions, foreign_key: 'owner_id', class_name: "Mission"
  has_many :received_missions, foreign_key: 'host_id', class_name: "Mission"
  has_and_belongs_to_many :categories, join_table: :categories_users

  after_create :send_welcome_email
  after_initialize :set_default_email_notifications, if: :new_record?

  has_one_attached :avatar

  validate :avatar_size_validation

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def avatar_size_validation
    if avatar.attached? && avatar.blob.byte_size > 5.megabytes
      errors.add(:avatar, "La taille de l'image est trop grande, choisissez une image de taille inférieure à 5mo")
    end
  end

  def set_default_email_notifications
    self.email_notifications = true
  end
end