class ChangeIsAvailableInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :is_available, :string
  end
end
