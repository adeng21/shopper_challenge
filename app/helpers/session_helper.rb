module SessionHelper
	BACKGROUND_CHECK_KEY = "background_check_authorized".freeze
	APPLICANT_SESSION_KEY = "current_applicant".freeze
	
	def logged_in?
		session[APPLICANT_SESSION_KEY].present?
	end

	def logged_out?
		!logged_in?
	end

	def background_check_authorized?
		session[APPLICANT_SESSION_KEY].present? && session[APPLICANT_SESSION_KEY][BACKGROUND_CHECK_KEY].present?
	end

end