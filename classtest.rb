require "pry"

class Event
  attr_reader :attendees
  attr_reader :destination
  
  def initialize(attendees, destination=nil)
    @attendees = attendees
    @destination = destination
  end
  
  def event_record
    if @destination
      puts @destination
    else
      puts "nil"
    end
    #{destination: attendees} if destination
  end
  
end

binding.pry