module Sessionable
	extend ActiveSupport::Concern
	include SessionHelper

	def log_in(attributes)
		session[APPLICANT_SESSION_KEY] = attributes
	end

	def log_out
		session.delete[APPLICANT_SESSION_KEY]
	end

	def background_check_authorized!
		return false unless logged_in?
		session[APPLICANT_SESSION_KEY][BACKGROUND_CHECK_KEY] = true
	end

	def applicant_session_params
		return {} if logged_out?
		session[APPLICANT_SESSION_KEY].reject { |k| k == BACKGROUND_CHECK_KEY }
	end
end