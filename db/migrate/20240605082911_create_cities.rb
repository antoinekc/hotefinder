class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.integer :postal_code
        t.string :name

      t.timestamps
    end
  end
end
