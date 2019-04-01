class Tool < ApplicationRecord

  has_many :rentals
  has_many :users, through: :rentals

  def available_for_rent?
    rentals.where(return: false).empty?
  end

  # def past_rental_date(user)
  #   Rental.past_rentals(self, user)
  # end # no need this method for past_rented-tools


end
