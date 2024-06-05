class City < ApplicationRecord
  has_many :missions
  has_many :users_cities_join
  has_many :users, through: :users_cities_join
end
