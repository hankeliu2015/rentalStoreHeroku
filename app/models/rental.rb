class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  #validate tool availa and start/return date
  #instance method (available_for_rent? in the tool class.
  validate :appropriate_start_date, :appropriate_return_date, :available_for_rent2?, on: :create

  validate :appropriate_checkout
  #validate reschedule_return with checkout and dates.
  validate :appropriate_reschedule_start_date, :appropriate_reschedule_end_date, on: :reschedule_return

  # def tool_available
  #   errors.add(:tool, " is not available for rent") unless self.tool.available_for_rent? #|| self == self.tool.current_rental
  # end

  def available_for_rent?
    errors.add(:tool, "Sorry, this Tool is not available for rent.") unless Rental.where(tool_id: self.tool_id).where(return: false).empty?
  end

  def available_for_rent2?
    #return unless tool

    #if the tool overdued, it is not vailable
    errors.add(:tool, "Sorry, this Tool is overdued by another customer and not available for rent.") if Rental.where(tool_id: self.tool_id).overdued

    #if the tool is in progress, compare the start and end dates.
    # tool.rentals.rentals_in_progress.any?
    if !Rental.where(tool_id: self.tool_id).rentals_in_progress.empty?
      rented_tool = Rental.where(tool_id: self.tool_id).rentals_in_progress.first
      if self.start_date >= rented_tool.start_date && self.start_date <= rented_tool.return_date # start_in_middle_of_rental
        errors.add(:tool, "Sorry, this Tool is rented, please try a different start dates.")
      elsif self.return_date >= rented_tool.start_date && self.return_date <= rented_tool.return_date
        errors.add(:tool, "Sorry, this Tool is rented, please try a different return date.")
      end
    end

    #if tool has scheduled rentals, iterate each future rental and compare dates. tool.rentals == Rental.where(tool_id: self.tool_id)

    if !Rental.where(tool_id: self.tool_id).scheduled_rentals.empty?
      Rental.where(tool_id: self.tool_id).scheduled_rentals.each do |rental|
        if self.start_date >= rental.start_date && self.start_date <= rental.return_date
          errors.add(:tool, "Sorry, this Tool is rented, please try a different start dates.")
        elsif self.return_date >= rental.start_date && self.return_date <= rental.return_date
          errors.add(:tool, "Sorry, this Tool is rented, please try a different return date.")
        end
      end
    end

  end #end of method

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
    where("return_date > ? AND start_date > ?", Date.today.midnight, Date.today.midnight) #have to add one more day for start_date. comparaion has problme compare Date.today.
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

  def self.rentals_in_progress  #wip
    checked_out?.not_returned.current_date_between_start_return
  end

  # def self.in_possession #replaced by rentals_in_progress
  #   where(return: false).select {|rental|
  #     rental if rental.start_date.strftime("%m/%d/%Y") <= Date.today.strftime("%m/%d/%Y") && rental.return_date.strftime("%m/%d/%Y") >= Date.today.strftime("%m/%d/%Y")
  #     }
  # end

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
