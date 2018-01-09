require 'csv'
require 'applicant_analysis_query'

CSV_HEADERS = ['count', 'week', 'workflow_state'].freeze

namespace :applicant_analysis do
	desc "analyze applicants"
	task :funnel, [:start_date, :end_date] => :environment do |t, args|
		start_date = args[:start_date].to_date
		end_date = args[:end_date].to_date

		query_results = ApplicantAnalysisQuery.new(start_date, end_date).results

		CSV.open("applicant_analysis.csv", "w") do |writer|
			writer << CSV_HEADERS
			query_results.each do |k, results|
				next if results.blank?
				results.each do |key, value|
					writer << [value, k, key]
				end
			end
		end
	end
end
