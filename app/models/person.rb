class Person < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
	has_many :digital_addresses, as: :addressable, :dependent => :destroy

	accepts_nested_attributes_for :digital_addresses

	def first_name
    name.scan(/\w+/).first
  end
end
