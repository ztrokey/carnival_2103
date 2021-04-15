require 'rspec'
require './lib/ride'
require './lib/attendee'

RSpec.describe Ride do
  it 'exists' do
    ride = Ride.new({name: 'Ferris Wheel', cost: 0})

    expect(ride).to be_instance_of(Ride)
  end

  it 'has attributes' do
    ride = Ride.new({name: 'Ferris Wheel', cost: 0})

    expect(ride.name).to eq("Ferris Wheel")
    expect(ride.cost).to eq(0)
  end
end
