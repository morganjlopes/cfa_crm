class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string   :name
      t.text     :bio
      t.integer  :gender
      t.string   :photo
      t.string   :slug

      t.timestamps
    end
  end
end
