class AddCommunitiesToTables < ActiveRecord::Migration
  def change
  	add_column :people,    :community_id, :integer
  	add_column :companies, :community_id, :integer
  	add_column :messages,  :community_id, :integer
  end
end
