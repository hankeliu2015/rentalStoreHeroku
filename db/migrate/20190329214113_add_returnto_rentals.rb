class AddReturntoRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :return, :boolean, default: false
  end
end
