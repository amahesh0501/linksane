class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.belongs_to :user
      t.text :url
      t.text :link_id
      t.text :sender_name
      t.text :sender_id
      t.text :message
      t.text :name
      t.text :caption
      t.text :picture_url
      t.text :description
      t.time :created_time

    end
  end
end
