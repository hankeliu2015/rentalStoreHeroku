class RemovePickedUpFromRentals < ActiveRecord::Migration[5.2]
  def change
    remvoe column :rentals, :picked_up, :boolean
  end
end
