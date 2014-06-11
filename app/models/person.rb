class Person < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
	has_many :digital_addresses, as: :addressable, :dependent => :destroy
	has_many :companies, through: :employments
	has_many :employments

	accepts_nested_attributes_for :digital_addresses
	accepts_nested_attributes_for :employments

	def first_name
    name.scan(/\w+/).first
  end
end