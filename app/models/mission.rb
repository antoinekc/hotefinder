class Mission < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :host, class_name: "User", foreign_key: "host_id"
  has_many :missions_categories_join
  has_many :categories, through: :missions_categories_join
  belongs_to :city
end



# class Mission < ApplicationRecord
#   belongs_to :owner, class_name: "User", 
#   belongs_to :host, class_name: "User"
#   has_many :missions_categories_join
#   has_many :categories, through: :missions_categories_join
#   belongs_to :city

# end
