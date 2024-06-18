class Mission < ApplicationRecord

  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_before_start_date

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :host, class_name: "User", foreign_key: "host_id"
  has_and_belongs_to_many :categories, join_table: :categories_missions
  belongs_to :city

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "ne peut pas être antérieure à la date du jour.")
    end
  end

  def end_date_cannot_be_before_start_date
    if end_date.present? && end_date < start_date
      errors.add(:start_date, "ne peut pas être antérieure à la date du démarrage.")
    end
  end

end
