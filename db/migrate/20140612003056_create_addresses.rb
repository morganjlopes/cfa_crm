class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string   :street_line_1
      t.string   :street_line_2
      t.string   :city
      t.string   :state
      t.string   :zip
      t.float    :latitude
      t.float    :longitude

      t.timestamps
    end

    add_column :people,    :address_id, :integer
    add_column :companies, :address_id, :integer
  end
end
