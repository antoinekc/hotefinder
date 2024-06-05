class Category < ApplicationRecord
  has_many :missions_categories_join
  has_many :missions, through: :missions_category_join
  has_many :users_categories_join
  has_many :users, through: :users_categories_join
end
