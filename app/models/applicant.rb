class Applicant < ApplicationRecord
	AVAILABLE_PHONE_TYPES = ["iPhone 10", "iPhone 8/8 Plus", "iPhone 7/7 Plus", "iPhone 6s/6s Plus", "iPhone 6/6 Plus", "Samsung Galaxy", "Google Pixel", "Other"].freeze
	AVAILABLE_REGIONS = ["SF/Bay Area", "Los Angeles", "New York", "Chicago", "Boston", "Seattle", "Portland"].freeze
	WORKFLOW_STATES = ["applied", "background_check_authorized", "quiz_started", "quiz_completed", "onboarding_requested", "onboarding_completed", "hired", "rejected"].freeze
	
	validates :first_name, :last_name, :email, presence: true
	validates :email, uniqueness: true, case_sensitive: false
	validates :phone_type, inclusion: AVAILABLE_PHONE_TYPES
	validates :region, inclusion: AVAILABLE_REGIONS
	# would use rails enum here but not persisting to DB
	validates :workflow_state, inclusion: WORKFLOW_STATES

	after_save :after_save_callback

	private

	def after_save_callback
		Rails.logger.info self.attributes
		puts "#{self.attributes}"
		# would never do this in real life but requirements stay dont persist to DB
		self.destroy
	end
end
