require "pry"

class Event
  attr_reader :attendees
  attr_reader :destination
  
  def initialize(attendees, destination)
    @attendees = attendees
    @destination = destination
  end
  
  def event_record
    {destination: attendees}
  end
  
end

binding.pry