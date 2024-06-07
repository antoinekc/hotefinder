class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :users_cities_join
  has_many :cities, through: :users_cities_join
  has_many :sent_missions, foreign_key: 'owner_id', class_name: "Mission"
  has_many :received_missions, foreign_key: 'host_id', class_name: "Mission"
  has_many :users_categories_join
  has_many :categories, through: :users_categories_join

  # Welcome email
  after_create :send_welcome_email

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
end
