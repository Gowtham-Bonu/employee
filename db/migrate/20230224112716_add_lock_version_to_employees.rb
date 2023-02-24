class AddLockVersionToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :lock_version, :integer
  end
end
