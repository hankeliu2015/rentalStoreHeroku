class RemovePickedUpFromRentals < ActiveRecord::Migration[5.2]
  def change
    remove_column :rentals, :picked_up, :boolean
  end
end
