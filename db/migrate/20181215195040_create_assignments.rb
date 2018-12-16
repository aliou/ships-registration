class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true, type: :uuid
      t.references :ship, foreign_key: true, index: true, type: :uuid

      t.index [:user_id, :ship_id], unique: true
      t.timestamps
    end
  end
end
