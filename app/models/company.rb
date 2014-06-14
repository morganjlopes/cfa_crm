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

	COMPANY_TYPE_BUSINESS      = 1
  COMPANY_TYPE_NONPROFIT     = 2
  COMPANY_TYPE_SCHOOL        = 3
  COMPANY_TYPE_CHURCH        = 4
  COMPANY_TYPE_PERSONAL      = 5

  mount_uploader :photo, ProfilePhotoUploader

  validates_presence_of :name,
                        :company_type

  def self.company_types
    {
      Company::COMPANY_TYPE_BUSINESS     => 'Business',
      Company::COMPANY_TYPE_NONPROFIT    => 'Nonprofit',
      Company::COMPANY_TYPE_SCHOOL       => 'School',
      Company::COMPANY_TYPE_CHURCH       => 'Church',
      Company::COMPANY_TYPE_PERSONAL     => 'Personal'
    }
  end
end
