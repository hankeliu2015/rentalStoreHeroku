class AddCheckoutToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :checkout, :boolean, default: false
  end
end
