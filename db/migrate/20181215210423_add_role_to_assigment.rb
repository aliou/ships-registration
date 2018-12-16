class AddRoleToAssigment < ActiveRecord::Migration[5.2]
  def up
    execute <<~SQL.strip
      CREATE TYPE assignment_role AS ENUM ('employee', 'manager', 'director', 'owner')
    SQL

    add_column :assignments, :role, :assignment_role, null: false,
                                                      default: 'employee'
  end

  def down
    remove_column :assignments, :role

    execute <<~SQL.strip
      DROP TYPE assignment_role
    SQL
  end
end
