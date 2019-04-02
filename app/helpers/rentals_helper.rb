module RentalsHelper

  def display_return_date(rental)
    rental.return_date.strftime("%a, %b %e, %y")
  end

  def display_start_date(rental)
    rental.start_date.strftime("%a, %b %e, %y")
  end

  def display_actual_return_date(rental) # not dry
    rental.actual_return_date.strftime("%a, %b %e, %y") if rental.actual_return_date
  end

  # def return_ontime?(rental) # not working?
  #   rental.return_date <= DateTime.new && rental.return == true
  # end

end #end of class
