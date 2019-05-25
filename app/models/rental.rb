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
    Rental.where(return: false).empty?
  end

  # tool checkout is when rental checkout is true and return is false.
  # rentals.where(checkout: true).where(return: false)
  # today date must ahead of return date.
  def self.checked_out?
    where("checkout = ? AND return = ?", true, false) && self.return_date.to_date >= Date.today
  end

  def self.tool_not_rented_or_not_scheduled?  #wip
    rentals.where(return: false).empty?
  end

  # tool checked out/noreturn && today's date < return date.
  # wip
  def self.tool_forget_return?
    where("checkout = ? AND return = ?", true, false)  && self.return_date.to_date < Date.today
  end

  def tool_scheduled  #wip
    rentals.where("")
  end


  def self.in_possession
    where(return: false).select {|rental|
      rental if rental.start_date.strftime("%m/%d/%Y") <= Date.today.strftime("%m/%d/%Y") && rental.return_date.strftime("%m/%d/%Y") >= Date.today.strftime("%m/%d/%Y")
      }
  end

  def self.scheduled_rentals

    # where(return: false).where("start_date > ?", Date.today)
    # above scope method can not compare today's date. 'Start_date'(if value is today's date) > Date.today => true
    where(return: false).select {|rental|
        rental if rental.start_date.to_date > Date.today
      }
  end

  def self.overdue #no need the argument(user). chain this method after @user.retnals ActiveRecord::Relation object
    where("return_date < ?", Date.today).where(return: false) #where(user_id: user.id) can be done in users controller show
  end


  def overdued_dates
    (Date.today - self.return_date.to_date).to_i
  end

  def self.past_rentals
    where(return: true)
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
