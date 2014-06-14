class AddAddressToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :address_id, :integer
  end
end
