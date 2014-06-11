class Company < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
	has_many :digital_addresses, as: :addressable, :dependent => :destroy
	has_many :people, through: :employments

	accepts_nested_attributes_for :digital_addresses
end
