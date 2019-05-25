class Tool < ApplicationRecord

  has_many :rentals
  has_many :users, through: :rentals

  # moved the following to rental model:
  # def available_for_rent?
  #   rentals.where(return: false).empty?
  # end

  # no need this method anymore
  # def current_rental
  #   rentals.find_by(return: false)
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

end #end of class
