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

end #end of class
