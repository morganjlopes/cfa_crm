class Person < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
  belongs_to :address
  
	has_many :digital_addresses, as: :addressable, :dependent => :destroy
	has_many :employments
	has_many :companies, through: :employments
	has_many :message_recipients
	has_many :messages, through: :message_recipients
	has_many :notes, as: :noteable, :dependent => :destroy

	accepts_nested_attributes_for :address
	accepts_nested_attributes_for :digital_addresses
	accepts_nested_attributes_for :employments

	def first_name
    name.scan(/\w+/).first
  end

  def email
  	if digital_addresses.where(:address_type => 2).first
  		digital_addresses.where(:address_type => 2).first.url
  	else
  		return nil
  	end
  end
end
