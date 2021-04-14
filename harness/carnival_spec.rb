require 'rspec'
require 'simplecov'
SimpleCov.start
require './lib/ride'
require './lib/attendee'
require './lib/carnival'

RSpec.configure do |config|
  config.default_formatter = 'doc'
  config.mock_with :mocha
end

RSpec.describe 'carnival spec' do
  before :each do
    @bumper_cars = Ride.new({name: "Bumper Cars", cost: 0})
    @ferris_wheel = Ride.new({name: "Ferris Wheel", cost: 0})
    @scrambler = Ride.new({name: "Scrambler", cost: 15})
    @bob = Attendee.new("Bob", 20)
    @sally = Attendee.new("Sally", 20)
    @jeffco_fair = Carnival.new("Jefferson County Fair")
  end

  describe 'Iteration 1' do
    it '1. Ride & Attendee Creation' do
      expect(Ride).to respond_to(:new).with(1).argument
      expect(@bumper_cars).to be_an_instance_of(Ride)
      expect(@bumper_cars).to respond_to(:name).with(0).argument
      expect(@bumper_cars.name).to eq("Bumper Cars")
      expect(@bumper_cars).to respond_to(:cost).with(0).argument
      expect(@bumper_cars.cost).to eq(0)
      expect(Attendee).to respond_to(:new).with(2).argument
      expect(@bob).to be_an_instance_of(Attendee)
      expect(@bob).to respond_to(:name).with(0).argument
      expect(@bob.name).to eq('Bob')
      expect(@bob).to respond_to(:spending_money).with(0).argument
      expect(@bob.spending_money).to eq(20)
      expect(@bob).to respond_to(:interests).with(0).argument
      expect(@bob.interests).to eq([])
    end

    it '2. Attendee #add_interest' do
      expect(@bob).to respond_to(:add_interest).with(1).argument
      @bob.add_interest("Bumper Cars")
      @bob.add_interest("Ferris Wheel")
      expect(@bob.interests).to eq(["Bumper Cars", "Ferris Wheel"])
    end
  end

  describe 'Iteration 2' do
    before :each do
      @bob.add_interest("Bumper Cars")
      @bob.add_interest("Ferris Wheel")
      @sally.add_interest("Scrambler")
    end

    it '3. Carnival ::new' do
      expect(Carnival).to respond_to(:new).with(1).argument
      expect(@jeffco_fair).to be_an_instance_of(Carnival)
      expect(@jeffco_fair).to respond_to(:name).with(0).argument
      expect(@jeffco_fair.name).to eq("Jefferson County Fair")
      expect(@jeffco_fair).to respond_to(:rides).with(0).argument
      expect(@jeffco_fair.rides).to eq([])
    end

    it '4. Carnival #add_ride' do
      expect(@jeffco_fair).to respond_to(:add_ride).with(1).argument
      @jeffco_fair.add_ride(@bumper_cars)
      @jeffco_fair.add_ride(@ferris_wheel)
      expect(@jeffco_fair.rides).to eq([@bumper_cars, @ferris_wheel])
    end

    it '5. Carnival #recommend_rides' do
      @jeffco_fair.add_ride(@bumper_cars)
      @jeffco_fair.add_ride(@ferris_wheel)
      @jeffco_fair.add_ride(@scrambler)
      expect(@jeffco_fair).to respond_to(:recommend_rides).with(1).argument
      expect(@jeffco_fair.recommend_rides(@bob)).to eq([@bumper_cars, @ferris_wheel])
      expect(@jeffco_fair.recommend_rides(@sally)).to eq([@scrambler])
    end
  end

  describe 'Iteration 3' do
    before :each do
      @scrambler_2 = Ride.new({name: "IMAX2",cost: 15})
      @jeffco_fair.add_ride(@bumper_cars)
      @jeffco_fair.add_ride(@ferris_wheel)
      @jeffco_fair.add_ride(@scrambler)
      @tj = Attendee.new("TJ", 7)
      @gabe = Attendee.new("Gabe", 10)
      @morgan = Attendee.new("Morgan", 15)
      @tj.add_interest("Scrambler")
      @tj.add_interest("Bumper Cars")
      @gabe.add_interest("Bumper Cars")
      @gabe.add_interest("Scrambler")
      @morgan.add_interest("Ferris Wheel")
      @morgan.add_interest("Bumper Cars")
      @bob.add_interest("Bumper Cars")
      @bob.add_interest("Ferris Wheel")
      @sally.add_interest("Bumper Cars")
    end

    it '6. Carnival #attendees' do
      expect(@jeffco_fair).to respond_to(:attendees).with(0).argument
      expect(@jeffco_fair.attendees).to eq([])
    end

    it '7. Carnival #admit' do
      expect(@jeffco_fair).to respond_to(:admit).with(1).argument
      @jeffco_fair.admit(@bob)
      @jeffco_fair.admit(@sally)
      expect(@jeffco_fair.attendees).to eq([@bob, @sally])
    end

    it '8. Carnival #attendees_by_ride_interest' do
      @jeffco_fair.admit(@bob)
      @jeffco_fair.admit(@sally)
      expected = {
        @bumper_cars => [@bob, @sally],
        @ferris_wheel => [@bob],
        @scrambler => [],
      }
      expect(@jeffco_fair).to respond_to(:attendees_by_ride_interest).with(0).argument
      expect(@jeffco_fair.attendees_by_ride_interest).to eq(expected)
    end

      it '9. Carnival #ticket_lottery_contestants' do
        @jeffco_fair.add_ride(@scrambler_2)
        @tj.add_interest("IMAX2")
        @gabe.add_interest("IMAX2")
        @jeffco_fair.admit(@tj)
        @jeffco_fair.admit(@gabe)
        @jeffco_fair.admit(@morgan)

        expected = [@tj, @gabe]
        expect(@jeffco_fair).to respond_to(:ticket_lottery_contestants).with(1).argument
        expect(@jeffco_fair.ticket_lottery_contestants(@scrambler_2)).to eq(expected)
      end

      it '10. Carnival #draw_lottery_winner' do
        @jeffco_fair.add_ride(@scrambler_2)
        @tj.add_interest("IMAX2")
        @gabe.add_interest("IMAX2")
        @jeffco_fair.admit(@tj)
        @jeffco_fair.admit(@gabe)
        @jeffco_fair.admit(@morgan)

        expect(@jeffco_fair).to respond_to(:draw_lottery_winner).with(1).argument
        expect(@jeffco_fair.draw_lottery_winner(@scrambler_2)).to eq("TJ").or(eq("Gabe"))
      end

      it '11. Carnival #announce_lottery_winner' do
        @jeffco_fair.add_ride(@scrambler_2)
        @tj.add_interest("IMAX2")
        @gabe.add_interest("IMAX2")
        @jeffco_fair.admit(@tj)
        @jeffco_fair.admit(@gabe)
        @jeffco_fair.admit(@morgan)
        @jeffco_fair.stubs(:draw_lottery_winner).returns('Gabe')
        expected = "Gabe has won the IMAX2 ride lottery"
        expect(@jeffco_fair).to respond_to(:announce_lottery_winner).with(1).argument
        expect(@jeffco_fair.announce_lottery_winner(@scrambler_2)).to eq(expected)
      end
  end

  describe 'Iteration 4' do
    before :each do
      @jeffco_fair = Carnival.new("Jefferson County Fair")
      @ferris_wheel = Ride.new({name: "Ferris Wheel",cost: 0})
      @scrambler = Ride.new({name: "Scrambler", cost: 15})
      @bumper_cars = Ride.new({name: "Bumper Cars",cost:  10})
      @jeffco_fair.add_ride(@ferris_wheel)
      @jeffco_fair.add_ride(@scrambler)
      @jeffco_fair.add_ride(@bumper_cars)

      # Interested in two rides but none in price range
      @tj = Attendee.new("TJ", 7)
      @tj.add_interest("Scrambler")
      @tj.add_interest("Bumper Cars")
      @jeffco_fair.admit(@tj)

      # Interested in two rides and only one is in price range
      @bob = Attendee.new("Bob", 10)
      @bob.add_interest("Bumper Cars")
      @bob.add_interest("Scrambler")
      @jeffco_fair.admit(@bob)

      # Interested in two rides and both are in price range, but can only afford one
      @sally = Attendee.new("Sally", 20)
      @sally.add_interest("Scrambler")
      @sally.add_interest("Bumper Cars")
      @jeffco_fair.admit(@sally)

      # Interested in two rides and both are in price range, and can afford both
      @morgan = Attendee.new("Morgan", 15)
      @morgan.add_interest("Ferris Wheel")
      @morgan.add_interest("Bumper Cars")
      @jeffco_fair.admit(@morgan)
    end

    it '12. Carnival #attendees_of_rides' do
      expected = {
        @ferris_wheel => [@morgan],
        @bumper_cars => [@bob, @morgan],
        @scrambler => [@sally]
      }
      expect(@jeffco_fair).to respond_to(:attendees_of_rides).with(0).argument
      expect(@jeffco_fair.attendees_of_rides).to eq(expected)
    end

    it '13. Carnival #admit reduces spending money' do
      expect(@tj.spending_money).to eq(7)
      expect(@bob.spending_money).to eq(0)
      expect(@sally.spending_money).to eq(5)
      expect(@morgan.spending_money).to eq(5)
    end

    it '14. Carnival #revenue' do
      expect(@jeffco_fair).to respond_to(:revenue).with(0).argument
      expect(@jeffco_fair.revenue).to eq(35)
    end
  end
end
