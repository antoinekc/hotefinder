class CreateJoinTableMissionCategory < ActiveRecord::Migration[7.1]
  def change
    create_join_table :missions, :categories do |t|
       t.index [:mission_id, :category_id]
       #t.index [:category_id, :mission_id]
    end
  end
end
