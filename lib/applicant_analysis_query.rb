class ApplicantAnalysisQuery
	DATE_STRING_FORMAT = "%Y-%m-%d".freeze

	def initialize(start_date, end_date)
		@start_date = start_date
		@end_date = end_date
	end

	def results
		weekly_results = {}
		
		weekly_ranges.each do |range|
			# initialize final weekly hash by the daily result
			weekly_results[range[0].to_s] = results_by_day[range[0].to_s]
		end

		sorted_keys = weekly_results.keys.sort


		current_key = sorted_keys[0]
		next_key = sorted_keys[1]

		# this list is sorted
		results_by_day.each do |key, values|
			#already in initial hash
			if weekly_results[key].present?
				current_key = key
				current_index = sorted_keys.find_index(key)
				next_key = sorted_keys[current_index + 1]
			end

			if key > current_key && key < next_key
				weekly_results[current_key] = weekly_results[current_key].merge(values) { |k, o, n| o + n }
			elsif key == next_key
				current_key = next_key
			elsif next_key.nil? #on last key
				weekly_results[current_key]
			end

		end

		weekly_results
	end

	private

	def results_by_day
		 sql_query.each_with_object({}) do |result, hash|
		 	key = result["day"]
		 	hash[key] ||= {}
		 	hash[key][result["workflow_state"]] = result["count"]
		 end
	end

	def sql_query

		ActiveRecord::Base.connection.execute %{
			SELECT
			#{beginning_of_week_in_sql} AS day,
			workflow_state,
			COUNT(*) as count,
			#{weekly_case_statement}

			FROM Applicants

			WHERE created_at >= '#{formatted_date start_date}'
			AND created_at <= '#{formatted_date end_date}'

			GROUP BY
			#{beginning_of_week_in_sql},
			workflow_state,
			#{weekly_case_statement}

			ORDER BY
			#{beginning_of_week_in_sql},
			workflow_state

		}
	end

	def beginning_of_week_in_sql
		# would normally use Date_trunc to get week here but sqllite doesnt support
		# not sure what the equivalent in sql lit would be and running out of time :(
		"date(created_at)"
	end

	def formatted_date(date)
		date.strftime DATE_STRING_FORMAT
	end

	def weekly_case_statement
		statements = []
		weekly_ranges.each_with_index do |array, index|
			statements << %{
				WHEN created_at >= '#{formatted_date array[0]}'
				AND created_at < '#{formatted_date array[1] + 1.day}' THEN #{index + 1}
			}
		end

		%{
			CASE 
			#{ statements.join(" ") }
			END
		}
	end

	def weekly_ranges
		@_weekly_ranges ||= get_ranges
	end

	def get_ranges
		first = start_date.beginning_of_week
		last = end_date.end_of_week

		(first..last).step(7).each_with_object([]) do |date, array|
			array << [date.beginning_of_week, date.end_of_week]
		end
	end

	attr_reader :start_date, :end_date
end