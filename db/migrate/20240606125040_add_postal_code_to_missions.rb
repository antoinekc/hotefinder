class AddPostalCodeToMissions < ActiveRecord::Migration[7.1]
  def change
    add_column :missions, :postal_code, :integer
  end
end
