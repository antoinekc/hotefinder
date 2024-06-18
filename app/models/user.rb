class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :cities
  has_many :sent_missions, foreign_key: 'owner_id', class_name: "Mission"
  has_many :received_missions, foreign_key: 'host_id', class_name: "Mission"
  has_and_belongs_to_many :categories, join_table: :categories_users

  # Welcome email
  after_create :send_welcome_email

  # Default email_notifications to true if not set
  after_initialize :set_default_email_notifications, if: :new_record?

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  # Avatar image
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [150, 150]
  end

  validate :avatar_size_validation

  private

  # Prevent large files
  def avatar_size_validation
    if avatar.attached? && avatar.blob.byte_size > 5.megabytes
      errors.add(:avatar, "La taille de l'image est trop grande, choisissez une image de taille inférieure à 5mo")
    end
  end

  def set_default_email_notifications
    self.email_notifications = true
  end
end
