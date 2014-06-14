class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string   :name
      t.string   :subdomain
      t.integer  :owner_id
      t.string   :logo
      t.boolean  :is_active, :default => true, :null => false

      t.timestamps
    end
  end
end
