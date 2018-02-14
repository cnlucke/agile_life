class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :type
      t.integer :creator_id
      t.integer :group_id
      t.integer :owner_id
      t.integer :parent_id
      t.string :title
      t.string :description
      t.string :status, default: "created"
      t.text :notes
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
