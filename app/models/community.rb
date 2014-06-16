class Community < ActiveRecord::Base
	has_many :people
	has_many :companies
	has_many :messages

	belongs_to :address
	belongs_to :owner, :class_name => "User"

	has_many :community_users
	has_many :users, through: :community_users
	has_many :digital_addresses, as: :addressable, :dependent => :destroy
	has_many :notes, as: :noteable, :dependent => :destroy

	accepts_nested_attributes_for :digital_addresses
	accepts_nested_attributes_for :address

	mount_uploader :photo, ProfilePhotoUploader

	validates_presence_of :name,
                        :subdomain,
                        :user_ids

	validates_uniqueness_of :name,
                       	  :subdomain
end
