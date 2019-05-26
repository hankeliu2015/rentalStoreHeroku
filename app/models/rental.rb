class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  #validate tool availa and start/return date
  #instance method (available_for_rent? in the tool class.
  validate :appropriate_start_date, :appropriate_return_date, :available_for_rent?, on: :create

  validate :appropriate_checkout
  #validate reschedule_return with checkout and dates.
  validate :appropriate_reschedule_start_date, :appropriate_reschedule_end_date, on: :reschedule_return

  # def tool_available
  #   errors.add(:tool, " is not available for rent") unless self.tool.available_for_rent? #|| self == self.tool.current_rental
  # end

  def available_for_rent?

    errors.add(:tool, "Sorry, this Tool is not available for rent.") unless Rental.where(tool_id: self.tool_id).where(return: false).empty?
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

  def self.return_date_in_future
    where("return_date > ? AND start_date > ?", Date.today, Date.tomorrow) #have to add one more day for start_date. comparaion has problme compare Date.today. 
  end

  def self.return_date_in_past
    where("return_date < ?", Date.today)
  end

  def self.rental_in_progress  #wip
    checked_out.return_date_in_future
  end


  def self.scheduled_rentals

    not_checked_out.not_returned.return_date_in_future

    # where(return: false).where("start_date > ?", Date.today)
    # above scope method can not compare today's date. 'Start_date'(if value is today's date) > Date.today => true
    # where(return: false).select {|rental|
    #     rental if rental.start_date.to_date > Date.today
    #   }

  end

  def self.overdued
    checked_out?.not_returned.return_date_in_past
    # where("return_date < ?", Date.today).where("return = ? AND  checkout = ?", false, true) #do not delete yet.
  end

  def overdued_dates
    (Date.today - self.return_date.to_date).to_i
  end


  def self.completed_rentals
    where("checkout = ? AND return = ?", true, true)
  end

  # def self.past_rentals # replaced it with completed_rentals method.
  #   where(return: true)
  # end

  def self.in_possession
    where(return: false).select {|rental|
      rental if rental.start_date.strftime("%m/%d/%Y") <= Date.today.strftime("%m/%d/%Y") && rental.return_date.strftime("%m/%d/%Y") >= Date.today.strftime("%m/%d/%Y")
      }
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
