class Category < ApplicationRecord
  has_many :missions_categories_join
  has_many :missions, through: :missions_category_join
  has_and_belongs_to_many :users, join_table: :categories_users
end
