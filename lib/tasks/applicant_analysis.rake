require 'csv'
CSV_HEADERS = ['count', 'week', 'workflow_state'].freeze

namespace :applicant_analysis do
	desc "analyze applicants"
	task :funnel, [:start_date, :end_date] => :environment do |t, args|
		start_date = args[:start_date].to_date
		end_date = args[:end_date].to_date

	end
end
