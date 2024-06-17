class Category < ApplicationRecord
  has_and_belongs_to_many :missions, join_table: :categories_missions
  has_and_belongs_to_many :users, join_table: :categories_users
end
