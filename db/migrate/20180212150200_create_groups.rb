class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :creator_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
