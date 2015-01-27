require "pry"

# add dinner club
# store member names
# member running totals

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
  
  =begin
  def print_output
    puts "Total Bill: " + sprintf("%.2f", total_bill)
    puts "Per Person: " + sprintf("%.2f", per_person)
  end
  =end
  
end

binding.pry