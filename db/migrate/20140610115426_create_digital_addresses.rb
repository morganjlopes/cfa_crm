class CreateDigitalAddresses < ActiveRecord::Migration
  def change
    create_table :digital_addresses do |t|
      t.integer  :address_type, :default => 1
      t.string   :url
      t.string   :addressable_type
      t.integer  :addressable_id
      t.integer  :position

      t.timestamps
    end
  end
end
