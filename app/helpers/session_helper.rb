module SessionHelper
	SESSION_KEY = "applicant_email".freeze


	def log_in(email)
		session[SESSION_KEY] = email
	end

	def log_out
		session.delete(SESSION_KEY)
	end

	def logged_in?
		session[SESSION_KEY].present?
	end

	def logged_out?
		!logged_in?
	end
end