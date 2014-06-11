class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string   :name
      t.text     :bio
      t.string   :slug
      t.string   :photo

      t.timestamps
    end
  end
end
