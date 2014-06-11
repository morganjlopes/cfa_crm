class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.integer  :person_id
      t.integer  :company_id
      t.string   :role

      t.timestamps
    end
  end
end
