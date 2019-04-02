class AddActualReturnDateToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :actual_return_date, :datetime
  end
end
