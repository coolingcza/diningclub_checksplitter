require "pry"

# Class: DinnerClub
#
# Models a dinner club that includes a number of diners.
#
# Attributes:
# @members     - Array: contains string values for each member's name.
# @member_list - Hash: contains running check totals for diners.
#
# Public Methods:
# #member_list_init
# #event_go


class DinnerClub
  
  def initialize(members)
    @members = members
  end
  
  def member_list_init
    @member_list = {}
    @members.each { |m| @member_list[m] = 0 }
    @member_list
  end
  
  def event_go(eventobj)
    event_check = CheckSplitter.new(eventobj.bill, eventobj.attendees.length)
    if eventobj.treat
      puts "Who is treating the Dinner Club?"
      treater = gets.chomp
      @member_list[treater] += event_check.total_bill
    else
      eventobj.attendees.each do |a| 
        @member_list[a] += event_check.per_person
      end
    end
    @member_list
  end
  
end
    

class Event
  attr_reader :attendees
  attr_reader :destination
  attr_reader :bill
  attr_reader :treat
  
  def initialize(attendees, destination, bill, treat=false)
    @attendees = attendees
    @destination = destination
    @bill = bill
    @treat = treat
  end
  
  def event_record
    {destination: attendees}
  end
  
end


class CheckSplitter
  
  attr_reader :tip
  attr_reader :bill
  attr_reader :party_size
  
  def initialize(bill, tip=15, party_size)
    @bill = bill
    @tip = tip/100.0
    @party_size = party_size
  end
  
  def total_bill
    bill + (bill * tip)
  end
  
  def per_person
    total_bill / party_size
  end
  
  #def print_output
  #  puts "Total Bill: " + sprintf("%.2f", total_bill)
  #  puts "Per Person: " + sprintf("%.2f", per_person)
  #end
  
end

group = DinnerClub.new(["Sally","Mark","John","Claire","Jim","Sunny"])

party = Event.new(["Sally","Mark","John","Claire","Jim","Sunny"], "Granite City", 120.45)
huzzah = Event.new(["Mark","Claire","Sunny"], "Chili's", 36.8, true)
holiday = Event.new(["Sally","Mark","John","Jim","Sunny"], "Silverthorn", 346.4)


binding.pry