class ApplicantsController < ApplicationController
	include Sessionable

	def new
		@applicant = Applicant.new
	end

	def create
		@applicant = Applicant.new(applicant_params)
		if @applicant.save
			log_in(applicant_params)
			redirect_to background_check_applicants_path
		else
			render :new
		end
	end

	def edit_applicant
		@applicant = Applicant.new(applicant_session_params)
	end

	def background_check
	end

	def background_check_authorized
		background_check_authorized!
		redirect_to confirmation_applicants_path
	end

	def confirmation
	end

	private

	def applicant_params
		params.require(:applicant).permit(
			:first_name, :last_name, :email, :region, :phone_type)
	end
end