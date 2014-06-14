class User < ActiveRecord::Base

	has_many :messages
	has_many :community_users
	has_many :communities, as: :owner
	has_many :communities, through: :community_users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
