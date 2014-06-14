class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :community

	has_many :message_recipients
	has_many :people, through: :message_recipients
end
