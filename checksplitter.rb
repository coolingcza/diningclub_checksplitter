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
# #event


class DinnerClub
  
  def initialize(members)
    @members = members
  end
  
  # Public: #member_list_init
  # Generates hash of member name keys set to initial value of zero.
  #
  # Parameters:
  # none
  #
  # Returns:
  # Populated @member_list hash.
  #
  # State Changes:
  # Sets @member_list values.
  
  def member_list_init
    @member_list = {}
    @members.each { |m| @member_list[m] = [0, 0] }
    @member_list
  end
  
  # Public: #event
  # Updates @member_list values of event attendees with portion of bill.
  #
  # Parameters:
  # attendees - Array: Names of event attendees.
  # bill      - Float: Bill for dinner event.
  # treat     - Boolean: Default is false. Set to true if one diner pays entire tab.
  #
  # Returns:
  # @member_list updated with event tab portions.
  #
  # State Changes:
  # Updates @member_list.
  
  def event(attendees, bill, treat=false)
    event_check = CheckSplitter.new(bill, attendees.length)
    if treat
      puts "Who is treating the Dinner Club?"
      treater = gets.chomp
      @member_list[treater][0] += event_check.total_bill
    else
      attendees.each do |a| 
        @member_list[a][0] += event_check.per_person
        @member_list[a][1] += 1
      end
    end
    @member_list
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

binding.pry