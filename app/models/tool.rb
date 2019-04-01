class Tool < ApplicationRecord

  has_many :rentals
  has_many :users, through: :rentals


  # def past_rental_date(user)
  #   Rental.past_rentals(self, user)
  # end # no need this method for past_rented-tools

end
