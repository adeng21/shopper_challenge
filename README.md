# README

Standard Rails App:
- Setup DB:
- Rake db:create
- Rake db:migrate


Generate the CSV:

rake 'applicant_analysis:funnel["2014-07-01", "2014-08-11"]'

# Main tradeoffs: 
- normally used to using PostgresSQL, which gives me the Date_Trunc function to parse weeks.
- Wasnt sure what the sql lite equivalent was so had to merge the values together manually. - spent a lot of time on this.
- Ran out of time at the end - due to the way I'm manually merging the values, the query will break if the start/end dates aren't exact weeks ("2014-08-10" will break for example).
- Spent the first half getting the basic application flow working, was going to come back and work ont he styling but ran out of time.