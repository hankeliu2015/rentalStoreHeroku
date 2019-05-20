class Tool < ApplicationRecord

  has_many :rentals
  has_many :users, through: :rentals

  # moved the following to rental model: 
  # def available_for_rent?
  #   rentals.where(return: false).empty?
  # end

  # new method to allow user book tools base on dates.
  def new_available_for_rent?

    if self.tool_not_rented_or_Not_scheduled?
      return true
    elsif self.tool_forget_return?
      return false
    elsif self.tool_scheduled

    end
  end #end of method


  def current_rental
    rentals.find_by(return: false)
  end

  # tool checkout is when rental checkout is true and return is false.
  # rentals.where(checkout: true).where(return: false)
  # today date must ahead of return date.
  def checkout?
    rentals.where("checkout = ? AND return = ?", true, false) && self.return_date.to_date >= Date.today
  end

  def tool_not_rented_or_Not_scheduled?
    rentals.where(return: false).empty?
  end

  # tool checked out/noreturn && today's date < return date.
  def tool_forget_return?
    rentals.where("checkout = ? AND return = ?", true, false)  && self.return_date.to_date < Date.today
  end

  def tool_scheduled
    rentals.where("")
  end

end #end of class
