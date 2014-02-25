class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :wall
      t.boolean :revoked, :default => false
      t.datetime :last_visit_time

      t.timestamps
    end
  end
end
