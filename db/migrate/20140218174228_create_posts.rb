class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :link
      t.text :description
      t.integer :vote_count, default: 0
      t.belongs_to :user
      t.belongs_to :wall

      t.timestamps
    end
  end
end
