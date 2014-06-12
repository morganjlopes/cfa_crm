class Company < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
  belongs_to :address
  
	has_many :digital_addresses, as: :addressable, :dependent => :destroy
	has_many :employments
	has_many :people, through: :employments
	has_many :notes, as: :noteable, :dependent => :destroy

	accepts_nested_attributes_for :digital_addresses
	accepts_nested_attributes_for :address
end
