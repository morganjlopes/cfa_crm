class DigitalAddress < ActiveRecord::Base
	belongs_to :addressable, polymorphic: true

	ADDRESS_TYPE_PHONE			 = 1
	ADDRESS_TYPE_EMAIL			 = 2
	ADDRESS_TYPE_WEBSITE     = 3
  ADDRESS_TYPE_FACEBOOK    = 4
  ADDRESS_TYPE_TWITTER     = 5
  ADDRESS_TYPE_INSTAGRAM   = 6
  ADDRESS_TYPE_LINKEDIN    = 7
  ADDRESS_TYPE_SKYPE     	 = 8
  ADDRESS_TYPE_GOOGLEPLUS  = 9
  ADDRESS_TYPE_GITHUB      = 10
  ADDRESS_TYPE_YOUTUBE     = 11
  ADDRESS_TYPE_VIMEO       = 12
  ADDRESS_TYPE_PINTEREST   = 13
  ADDRESS_TYPE_FOURSQUARE  = 14

  def self.address_types
    {
			DigitalAddress::ADDRESS_TYPE_PHONE			  => 'Phone',
			DigitalAddress::ADDRESS_TYPE_EMAIL			  => 'Email',
			DigitalAddress::ADDRESS_TYPE_WEBSITE			=> 'Website',
			DigitalAddress::ADDRESS_TYPE_FACEBOOK			=> 'Facebook',
			DigitalAddress::ADDRESS_TYPE_TWITTER			=> 'Twitter',
			DigitalAddress::ADDRESS_TYPE_INSTAGRAM		=> 'Instagram',
			DigitalAddress::ADDRESS_TYPE_LINKEDIN			=> 'Linkedin',
			DigitalAddress::ADDRESS_TYPE_SKYPE				=> 'Skype',
			DigitalAddress::ADDRESS_TYPE_GOOGLEPLUS		=> 'Google+',
			DigitalAddress::ADDRESS_TYPE_GITHUB				=> 'Github',
			DigitalAddress::ADDRESS_TYPE_YOUTUBE			=> 'Youtube',
			DigitalAddress::ADDRESS_TYPE_VIMEO				=> 'Vimeo',
      DigitalAddress::ADDRESS_TYPE_PINTEREST    => 'Pinterest',
      DigitalAddress::ADDRESS_TYPE_FOURSQUARE   => 'Four Square',
    }
  end

  def icon
    case address_type
      when ADDRESS_TYPE_PHONE
        "icon-iphone"
      when ADDRESS_TYPE_EMAIL
        "icon-emailalt"
      when ADDRESS_TYPE_WEBSITE
        "icon-globe"
      when ADDRESS_TYPE_FACEBOOK
        "icon-facebook"
      when ADDRESS_TYPE_TWITTER
        "icon-twitter"
      when ADDRESS_TYPE_INSTAGRAM
        "icon-instagram"
      when ADDRESS_TYPE_LINKEDIN
        "icon-linkedin"
      when ADDRESS_TYPE_SKYPE
        "icon-skype"
      when ADDRESS_TYPE_GOOGLEPLUS
        "icon-googleplus"
      when ADDRESS_TYPE_GITHUB
        "icon-github"
      when ADDRESS_TYPE_YOUTUBE
        "icon-youtube"
      when ADDRESS_TYPE_VIMEO
        "icon-vimeo"
      when ADDRESS_TYPE_PINTEREST
        "icon-pinterest"
      when ADDRESS_TYPE_FOURSQUARE
        "icon-foursquare"
    end
  end
end
