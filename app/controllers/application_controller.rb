class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(current_user)
	  communities_path
	end

	def load_community_from_subdomain
		@community = Community.find_by_subdomain!(request.subdomain)

		unless @community.users.where(:id => current_user.id).present?
			redirect_to root_url(:subdomain => false), :notice => "You are not authorized to enter. If you feel as though this is an error, please contact your supervisor."
		end
	end

	protected

	def configure_permitted_parameters
	  # Only add some parameters
	  # devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name, :phone]
	end
end
