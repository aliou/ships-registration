class CreateShips < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto'

    create_table :ships, id: :uuid do |t|
      t.string :name, null: false
      t.text :note

      t.references :fleet, index: true

      t.timestamps
    end
  end
end
