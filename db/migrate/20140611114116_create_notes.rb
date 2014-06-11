class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text     :body
      t.date     :reminder_ds
      t.datetime :reminder_sent_dts
      t.integer  :user_id
      t.string   :attachment
      t.integer  :noteable_id
      t.string   :noteable_type

      t.timestamps
    end
  end
end
