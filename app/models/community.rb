class Community < ActiveRecord::Base
	has_many :people
	has_many :companies
	has_many :messages

	belongs_to :address
	belongs_to :owner, :class_name => "User"

	has_many :community_users
	has_many :users, through: :community_users
	has_many :digital_addresses, as: :addressable, :dependent => :destroy

	accepts_nested_attributes_for :digital_addresses
	accepts_nested_attributes_for :address

	mount_uploader :photo, ProfilePhotoUploader
end
