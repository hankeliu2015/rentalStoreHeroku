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

  def date_scheduled_for_rent?(user_id, tool_id, date)

    #need to find that rental instance from user_id and tool_id where return is false.
    rental = Rental.where(user_id: user_id).where(tool_id: tool_id).where(return: false)
    #binding.pry
    date >= rental[0].start_date.to_date && date <= rental[0].return_date.to_date
  end

  # def return_ontime?(rental) # not working?
  #   rental.return_date <= DateTime.new && rental.return == true
  # end

end #end of class
