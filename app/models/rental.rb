class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  validate :appropriate_start_date, :appropriate_return_date

  #validate :appropriate_return_date
  #validate :appropriate_return_date

  # def self.available_to_rent? # replaced by instance method (available_for_rent? in the tool class.
  #   where(return: false).empty?
  # end

  def self.in_possession
    where(return: false).select {|rental|
      rental if rental.start_date.strftime("%m/%d/%Y") <= Date.today.strftime("%m/%d/%Y") && rental.return_date.strftime("%m/%d/%Y") >= Date.today.strftime("%m/%d/%Y")
      }
  end

  # def self.in_possession
  #   where(return: false).select do |rental|
  #     if rental.start_date.strftime("%m/%d/%Y") <= Date.today.strftime("%m/%d/%Y") && rental.return_date.strftime("%m/%d/%Y") >= Date.today.strftime("%m/%d/%Y")
  #       rental
  #     end
  #   end
  # end

  # def self.in_progress #replaced by in_prossession
  #   where("start_date <= ?", Date.today).where("return_date >= ?", Date.today).where(return: false)
  # end

  def self.scheduled_rentals
    where(return: false).select {|rental|
        rental if rental.start_date.to_date > Date.today
      }
  end

  def self.overdue #no need the argument(user). chain this method after @user.retnals ActiveRecord::Relation object
    where("return_date < ?", Date.today).where(return: false) #where(user_id: user.id) can be done in users controller show
    #binding.pry
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

end #end of class
