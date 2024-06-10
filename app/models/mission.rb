class Mission < ApplicationRecord

  validate :start_date_cannot_be_in_the_past

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :host, class_name: "User", foreign_key: "host_id"
  has_many :missions_categories_join
  has_many :categories, through: :missions_categories_join
  belongs_to :city

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "Ne pas pas être antérieure à la date du jour.")
    end
  end

end


# class Mission < ApplicationRecord
#   belongs_to :owner, class_name: "User", 
#   belongs_to :host, class_name: "User"
#   has_many :missions_categories_join
#   has_many :categories, through: :missions_categories_join
#   belongs_to :city

# end
