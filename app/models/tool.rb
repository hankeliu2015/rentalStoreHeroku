class Tool < ApplicationRecord

  has_many :rentals
  has_many :users, through: :rentals


  def past_rental_date(user)
    Rental.past_tool_rental(self, user)
  end

end
