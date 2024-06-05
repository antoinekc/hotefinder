class CreateMissions < ActiveRecord::Migration[7.1]
  def change
    create_table :missions do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :host, index: true
      t.references :owner, index: true
      t.references :city, index: true
      t.string :status

      t.timestamps
    end
  end
end
