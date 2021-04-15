require 'rspec'
require './lib/ride'
require './lib/attendee'

RSpec.describe Attendee do
  it 'exists' do
    attendee = Attendee.new('Bob', 20)

    expect(attendee).to be_instance_of(Attendee)
  end

  it 'has attributes' do
    attendee = Attendee.new('Bob', 20)

    expect(attendee.name).to eq("Bob")
    expect(attendee.spending_money).to eq(20)
  end
end

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
