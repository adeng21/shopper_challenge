class ApplicantsController < ApplicationController
	include Sessionable
	
	def new
		@applicant = Applicant.new
	end

	def create
		@applicant = Applicant.new(applicant_params)
		if @applicant.save
			log_in(@applicant.email)
			redirect_to background_check_applicants_path
		else
			@errors = @applicant.errors.messages
			render :new
		end
	end

	def edit
	end

	def background_check
	end

	def background_check_authorized
	end

	def confirmation
	end

	private

	def applicant_params
		params.require(:applicant).permit(
			:first_name, :last_name, :email, :region, :phone_type)
	end
end