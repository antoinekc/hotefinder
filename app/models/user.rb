class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :users_cities_join
  has_many :cities, through: :users_cities_join
  has_many :sent_missions, foreign_key: 'owner_id', class_name: "Mission"
  has_many :received_missions, foreign_key: 'host_id', class_name: "Mission"
  has_many :users_categories_join
  has_many :categories, through: :users_categories_join

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [150, 150]
  end
end
