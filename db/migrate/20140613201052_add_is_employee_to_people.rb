class AddIsEmployeeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :is_employee, :boolean, :default => false, :null => false
  end
end
