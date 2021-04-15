class Carnival
  attr_reader :name, :rides, :attendees

  def initialize(name)
    @name = name
    @rides = []
    @attendees = []
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

  def admit(attendee)
    attendees << attendee
  end
end
