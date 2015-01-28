require "pry"

# Class: DinnerClub
#
# Models a dinner club that includes a number of diners.
#
# Attributes:
# @members     - Array: contains string values for each member's name.
# @member_list - Hash: contains running check totals for diners.
# @log         - Array: (maybe)
#
# Public Methods:
# #member_list_init
# #event_go


class DinnerClub
  
  attr_reader :member_list
  
  def initialize(members)
    @members = members
    @member_list = {}
    @members.each { |m| @member_list[m] = [0,[]] }
  end
  
  # Public: #event_go
  # Updates @member_list with member tabs for given event, adds destination to 
  # attendees' records.
  #
  # Parameters:
  # eventobj - Event: object generated by Event class.
  #
  # Returns:
  # updated @member_list.
  #
  # State Changes:
  # Updates running total and destination array values in @member_list.
  
  def event_go(eventobj)
    event_check = CheckSplitter.new(eventobj.bill, eventobj.attendees.length)
    if eventobj.treat
      @member_list[eventobj.treater][0] += event_check.total_bill
    else
      eventobj.attendees.each do |a| 
        @member_list[a][0] += event_check.per_person
      end
    end
    eventobj.attendees.each { |a| @member_list[a][1] << eventobj.destination }
    @member_list
  end
  
end
    

# Class: Event
#
# Models an event attended by a Dinner Club.
#
# Attributes:
# @attendees    - Array: Members of dinner club attending event.
# @destination  - String: restaurant name where event is hosted.
# @bill         - Float: Bill for event for entire group.
# @treat        - Boolean: True if one member of the dinner club pays entire bill.
# @treater      - String: acquired if @treat, name of member who pays entire bill.
#
# Public Methods:
# none

class Event
  attr_reader :attendees
  attr_reader :destination
  attr_reader :bill
  attr_reader :treat
  attr_reader :treater
  
  def initialize(attendees, destination, bill, treat=false)
    @attendees = attendees
    @destination = destination
    @bill = bill
    @treat = treat
    if @treat
      puts "Who is treating?"
      @treater = gets.chomp
    end
  end

end

# Class: CheckSplitter
#
# Given a single bill, calculates restaurant tab for member of large party including tip.
#
# Attributes:
# @bill       - Float: bill for entire group.
# @tip        - Integer: percent tip to leave. Default: 15.
# @party_size - Integer: number of people in the party.
#
# Public Methods:
# #total_bill
# #per_person

class CheckSplitter
  
  attr_reader :tip
  attr_reader :bill
  attr_reader :party_size
  
  def initialize(bill, tip=15, party_size)
    @bill = bill
    @tip = tip/100.0
    @party_size = party_size
  end
  
  # Public: #total_bill
  # Calculates the bill plus tip.
  #
  # Parameters:
  # bill - bill for entire group.
  # tip  - decimal tip number.
  #
  # Returns:
  # total_bill: bill including tip.
  #
  # State Changes:
  # None.
  
  def total_bill
    @bill + (@bill * @tip)
  end
  
  # Public: #per_person
  # Returns amount of tab for each member of dining party.
  #
  # Parameters:
  # total_bill - Return from total_bill method.
  # party_size - Integer: size of dining party.
  #
  # Returns:
  # Per_person: tab per party member.
  #
  # State Changes:
  # None.
  
  def per_person
    total_bill / @party_size
  end
  
end

group = DinnerClub.new(["Sally","Mark","John","Claire","Jim","Sunny"])

party = Event.new(["Sally","Mark","John","Claire","Jim","Sunny"], "Granite City", 120.45)
lunch = Event.new(["Mark","Claire","Sunny"], "Chili's", 36.8, true)
holiday = Event.new(["Sally","Mark","John","Jim","Sunny"], "Silverthorn", 346.4)


binding.pry