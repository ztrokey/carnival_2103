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

  it 'can recommend rides to attendees' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)
    bob = Attendee.new('Bob', 20)
    sally = Attendee.new('Sally', 20)
    bob.add_interest('Ferris Wheel')
    bob.add_interest('Bumper Cars')
    sally.add_interest('Scrambler')

    expect(jeffco_fair.recommend_rides(bob)).to eq([ferris_wheel, bumper_cars])
    expect(jeffco_fair.recommend_rides(sally)).to eq([scrambler])
  end

  it 'has attendees array' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)

    expect(jeffco_fair.attendees).to eq([])
  end

  it 'can add attendees' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)
    bob = Attendee.new("Bob", 0)
    bob.add_interest('Ferris Wheel')
    bob.add_interest('Bumper Cars')
    sally = Attendee.new('Sally', 20)
    sally.add_interest('Bumper Cars')
    johnny = Attendee.new("Johnny", 5)
    johnny.add_interest('Bumper Cars')
    jeffco_fair.admit(bob)
    jeffco_fair.admit(sally)
    jeffco_fair.admit(johnny)

    expect(jeffco_fair.attendees).to eq([bob, sally, johnny])
  end

  it 'can sort attendees by ride interests' do
    jeffco_fair = Carnival.new("Jefferson County Fair")
    ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
    bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
    scrambler = Ride.new({name: 'Scrambler', cost: 15})
    jeffco_fair.add_ride(ferris_wheel)
    jeffco_fair.add_ride(bumper_cars)
    jeffco_fair.add_ride(scrambler)
    bob = Attendee.new("Bob", 0)
    bob.add_interest('Ferris Wheel')
    bob.add_interest('Bumper Cars')
    sally = Attendee.new('Sally', 20)
    sally.add_interest('Bumper Cars')
    johnny = Attendee.new("Johnny", 5)
    johnny.add_interest('Bumper Cars')
    jeffco_fair.admit(bob)
    jeffco_fair.admit(sally)
    jeffco_fair.admit(johnny)

    expect(jeffco_fair.ride_hash_keys).to eq([ferris_wheel, bumper_cars, scrambler])
    # expect(jeffco_fair.keys_and_interests).to eq([])
    expect(jeffco_fair.ride_and_attendee).to eq([])
    expect(jeffco_fair.attendees_by_ride_interest).to eq(ferris_wheel => "interested attendee", bumper_cars => "interested attendee", scrambler => "interested attendee")
    # expect(jeffco_fair.attendees_by_ride_interest).to eq({:ferris_wheel => [bob], :bumper_cars => [bob, sally, johnny], :scrambler => []})
  end
end

# pry(main)> jeffco_fair.ticket_lottery_contestants(bumper_cars)
# #=> [#<Attendee:0x00007ffab70bfce8...>, #<Attendee:0x00007ffab7172d70...>]
#
# pry(main)> jeffco_fair.draw_lottery_winner(bumper_cars)
# #=> "Johnny"
#
# #In the above method, with this setup, "Johnny" or "Bob" could be returned here - Fun!
#
# pry(main)> jeffco_fair.draw_lottery_winner(ferris_wheel)
# #=> nil
#
# #If no contestants are eligible for the lottery, nil is returned.
#
# pry(main)> jeffco_fair.announce_lottery_winner(scrambler)
# #=> "Bob has won the IMAX exhibit"
#
# #We realize that, in this setup, Bob is not interested in the scrambler.  However, in your test, the result should match exactly.  You will need to stub the return of `draw_lottery_winner` as the above method should depend on that method :)
#
# pry(main)> jeffco_fair.announce_lottery_winner(ferris_wheel)
# #=> "No winners for this lottery"
#
# #If there are no contestants, there are no winners.
#
# ```
