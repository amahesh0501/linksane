class CreateWalls < ActiveRecord::Migration
  def change
    create_table :walls do |t|
      t.string :name
      t.string :alias
      t.string :description
      t.string :access_code
      t.integer :admin_id
      t.timestamps
    end
  end
end
