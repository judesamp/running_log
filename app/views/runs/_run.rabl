object @run
attributes :distance
attributes :run_time
attributes :notes
attributes :route_name
attributes :id
attributes :user_id
node(:run_date) { |run| pretty_date(run.run_date)}
node(:pace) { |run| pretty_pace(run.per_mile_pace)}
node(:run_id) { |run| run.id}






