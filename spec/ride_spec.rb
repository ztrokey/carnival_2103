require 'rspec'
require './lib/ride'
require './lib/attendee'

RSpec.describe Ride do
  it 'exists' do
    ride = Ride.new({name: 'Ferris Wheel', cost: 0})

    expect(ride).to be_instance_of(Ride)
  end
end



#
# pry(main)> ride.name
# #=> "Ferris Wheel"
#
# pry(main)> ride.cost
# #=> 0
#
# pry(main)> attendee = Attendee.new('Bob', 20)
# #=> #<Attendee:0x00007ff88ea979a8...>
#
# pry(main)> attendee.name
# #=> "Bob"
#
# pry(main)> attendee.spending_money
# #=> 20
#
# pry(main)> attendee.interests
# #=> []
#
# pry(main)> attendee.add_interest('Bumper Cars')
#
# pry(main)> attendee.add_interest('Ferris Wheel')
#
# pry(main)> attendee.interests
# #=> ["Bumper Cars", "Ferris Wheel"]
