class Note < ActiveRecord::Base
	belongs_to :noteable, polymorphic: true
	belongs_to :user
end
