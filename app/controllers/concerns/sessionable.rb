module Sessionable
	extend ActiveSupport::Concern

	include SessionHelper

	def log_in(email)
		session[SESSION_KEY] = email
	end

	def log_out
		session.delete(SESSION_KEY)
	end
end