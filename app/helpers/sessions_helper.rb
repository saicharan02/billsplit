module SessionsHelper
	def logged_in?
		!current_user.nil?
	end

	def log_in(user)
		session[:user_id] = user[:id]
	end

	def logout_user
		if current_user
			session.delete(:user_id)
			current_user = nil
		end

		if session[:session_token]
			session[:session_token] = nil
		end
	end


	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end
end
