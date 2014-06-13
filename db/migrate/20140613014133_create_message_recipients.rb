class CreateMessageRecipients < ActiveRecord::Migration
  def change
    create_table :message_recipients do |t|
      t.integer  :message_id
      t.integer  :person_id

      t.timestamps
    end
  end
end
