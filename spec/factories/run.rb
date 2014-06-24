FactoryGirl.define do

  factory :run do |f|

    f.run_date              Date.today
    f.distance              3.1
    f.route_name            "Neighborhood 1"
    f.run_time              30
    f.user                  factory: :user

  end

end