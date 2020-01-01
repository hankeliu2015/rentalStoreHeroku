class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  #validate tool available and start/return date
  validate :appropriate_start_date, :appropriate_return_date, :available_for_rent?, on: :create

  validate :appropriate_checkout

  #validate reschedule_return with checkout and dates.
  validate :appropriate_reschedule_start_date, :appropriate_reschedule_end_date, on: :reschedule_return

  paginates_per 12
  # max_paginates_per 5

  def available_for_rent?
    return unless tool

    #if the tool overdued_status true?, it is not vailable
    errors.add(:tool, "Sorry, this Tool is overdued by another customer and not available for rent.") if tool.rentals.overdued_status? #repalced Rental.where(tool_id: self.tool_id).overdued_status?

    if tool.rentals.in_progress.any? ##replace Rental.where(tool_id: self.tool_id).in_progress.any?
      # rented_tool = Rental.where(tool_id: self.tool_id).in_progress.first # moved to start(end)_in_middle_of_rental method.

      rental = tool.rentals.in_progress.first

      if start_in_middle_of_rental(rental)
        errors.add(:tool, "Sorry, this Tool is currently rented, please try a different start date.")
      elsif end_in_middle_of_rental(rental)
        errors.add(:tool, "Sorry, this Tool is currently rented, please try a different return date.")
      end
    end

    #if tool has scheduled rentals, iterate each future rental and compare dates. tool.rentals == Rental.where(tool_id: self.tool_id)

    if tool.rentals.scheduled.any? #replace Rental.where(tool_id: self.tool_id).scheduled.any?
      tool.rentals.scheduled.each do |rental|

        #pass the @rental into start_in_middle_of_rental2
        if start_in_middle_of_rental(rental) #self.start_date >= rental.start_date && self.start_date <= rental.return_date
          errors.add(:tool, "Sorry, this Tool is booked on this day, please try a different start date.")
        elsif end_in_middle_of_rental(rental)
          errors.add(:tool, "Sorry, this Tool is booked on this day, please try a different return date.")
        end
      end
    end

  end #end of method


  def start_in_middle_of_rental(rental)
     self.start_date >= rental.start_date && self.start_date <= rental.return_date
  end

  def end_in_middle_of_rental(rental)
    self.return_date >= rental.start_date && self.return_date <= rental.return_date
  end

  def self.checked_out?
    where(checkout: true)
    #where("start_date <= ? and return_date >= ?", Date.today, Date.today)
  end

  def self.not_checked_out
    where(checkout: false)
    #where("start_date >= ?", Date.today)
  end

  def self.returned
    where(return: true)
  end

  def self.not_returned
    where(return: false)
  end

  def self.overdued_status?  #return if true of false on overdued status
    #binding.pry
    checked_out?.not_returned.return_date_in_past.any?
  end

  def self.overdued #return the overdued objects
    checked_out?.not_returned.return_date_in_past
  end

  def overdued_dates
    (Date.today - self.return_date.to_date).to_i
  end

  def self.start_date_in_past
    where("start_date < ?", Date.today.midnight)
  end

  def self.return_date_in_future
    where("return_date > ? AND start_date > ?", Date.today.midnight, Date.today.midnight) #Date.today.midnight will resovled the comparaion issue when start_date is today.
  end

  def self.return_date_in_past
    where("return_date < ?", Date.today.midnight)
  end

  def self.current_date_between_start_return #wip
    # where("start_date <= ? AND return_date >= ?", Date.today, Date.today)
    self.select {|rental|
      rental if rental.start_date.strftime("%m/%d/%Y") <= Date.today.strftime("%m/%d/%Y") && rental.return_date.strftime("%m/%d/%Y") >= Date.today.strftime("%m/%d/%Y")
      }
  end

  def self.in_progress  #wip
    checked_out?.not_returned.current_date_between_start_return
  end

  def self.aday_before_return
    #all the in_progress rentals , which current date is one day way from return date.
    self.not_returned.select {|rental|
      rental if (rental.return_date.to_date - Date.today).to_i == 1
    }
  end

  # def self.in_possession #replaced by in_progress
  #   where(return: false).select {|rental|
  #     rental if rental.start_date.strftime("%m/%d/%Y") <= Date.today.strftime("%m/%d/%Y") && rental.return_date.strftime("%m/%d/%Y") >= Date.today.strftime("%m/%d/%Y")
  #     }
  # end

  def self.scheduled

    not_checked_out.not_returned.return_date_in_future

    # where(return: false).where("start_date > ?", Date.today)
    # above scope method can not compare today's date. 'Start_date'(if value is today's date) > Date.today => true
    # where(return: false).select {|rental|
    #     rental if rental.start_date.to_date > Date.today
    #   }

  end

  def self.completed
    where("checkout = ? AND return = ?", true, true)
  end

  # def self.past_rentals # replaced it with completed method.
  #   where(return: true)
  # end

  def self.forget_checkout
    where(checkout: false).where(return: false).start_date_in_past
  end



  def appropriate_start_date
    errors.add(:start_date, " for rental must start from today or after") if self.start_date.to_date < Date.today
  end

  def appropriate_return_date #untested.
    errors.add(:return_date, "Return Date must be at least one day after the start date") if self.return_date.to_date <= self.start_date.to_date
  end

  def appropriate_reschedule_start_date
    if self.checkout == true && self.start_date_was.to_date != self.start_date.to_date #if the tool is checkouted, do not want people change start date.
      errors.add(:start_date, "Tool already checked out, can not change start date, please choose the original start date")

    elsif self.checkout == false && self.start_date.to_date < Date.today
      errors.add(:start_date, " Your rental start date must start from today or after")
    end
  end

  def appropriate_reschedule_end_date
    errors.add(:return_date, "Return Date must be at least one day after the start date") if self.return_date.to_date <= self.start_date.to_date
  end

  def appropriate_checkout
    errors.add(:checkout, "Tools can not be checked out before start date") if self.checkout == true && self.start_date.to_date > Date.today
  end

end #end of class
