# if Rails.env.production?
#   require 'rufus-scheduler'
#
#   scheduler = Rufus::Scheduler.new
#
#   scheduler.every '1m' do
#     puts 'Hello... Rufus'
#   end
  # scheduler.join
# end
Rufus::Scheduler.new.every '1m' do
  puts "Observations count: #{Observation.count}"
end