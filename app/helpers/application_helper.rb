module ApplicationHelper
	include SessionsHelper

	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		# else
		# 	@current_user = User.new_guest
		# 	log_in(@current_user)
		end
	end

	def current_user?(user)
		user == current_user
	end

  	def require_login
		unless logged_in?
			flash[:danger] = "Please Log in"
			redirect_to login_url
		end
  	end
end
