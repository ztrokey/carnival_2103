require 'rspec'
require './lib/ride'
require './lib/attendee'
require './lib/carnival'

RSpec.describe Carnival do
  it 'exists' do
    jeffco_fair = Carnival.new("Jefferson County Fair")

    expect(jeffco_fair).to be_instance_of(Carnival)
  end

  it 'has attributes' do
    jeffco_fair = Carnival.new("Jefferson County Fair")

    expect(jeffco_fair.name).to eq("Jefferson County Fair")
    expect(jeffco_fair.rides).to eq([])
  end

  it 'can add rides' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)

    expect(jeffco_fair.rides).to eq([ferris_wheel, bumper_cars, scrambler])
  end
end

#
# pry(main)> bob = Attendee.new('Bob', 20)
# #=> #<Attendee:0x00007fe59507dc80...>
#
# pry(main)> sally = Attendee.new('Sally', 20)
# #=> #<Attendee:0x00007fe593ac3318...>
#
# pry(main)> bob.add_interest('Ferris Wheel')
#
# pry(main)> bob.add_interest('Bumper Cars')
#
# pry(main)> sally.add_interest('Scrambler')
#
# pry(main)> jeffco_fair.recommend_rides(bob)
# #=> [#<Ride:0x00007fe59506ede8...>, #<Ride:0x00007fe594851930...>]
#
# pry(main)> jeffco_fair.recommend_rides(sally)
# #=> [#<Ride:0x00007fe59314eb98...>]
