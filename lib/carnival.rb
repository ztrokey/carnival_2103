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

  def ride_and_attendee
    r_a = []
    rides.each do |ride|
      attendees.each do |attendee|
        r_a << attendee if attendee.interests.include?(ride.name)
      end
    end
    r_a
  end

  def attendees_by_ride_interest
    require "pry"; binding.pry
    Hash[ride_hash_keys.collect { |ride| [ride, "interested attendee" ] } ]
  end

  def ride_hash_keys
    keys = []
    rides.each do |ride|
      keys << ride
    end
    keys
  end

  def keys_and_interests
    k_i = []
    attendees.each do |attendee|
      k_i << attendee.interests
    end
    k_i
  end
end 
# look at each ride, look at each attendees interest, if interest.include?
# ride assign attendee to value of ride
