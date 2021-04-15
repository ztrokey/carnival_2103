class Carnival
  attr_reader :name, :rides

  def initialize(name)
    @name = name
    @rides = []
  end

  def add_ride(ride)
    rides << ride
  end

  def recommend_rides(attendee)
    recommended_rides = []
    rides.each do |ride|
      attendee.interests.each do |interest|
        if ride.name == interest
          recommended_rides << ride
        end
      end
    end
    recommended_rides
  end
end
