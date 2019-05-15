class RemoveReturnedFromRentals < ActiveRecord::Migration[5.2]
  def change
    remove_column :rentals, :returned, :boolean
  end
end
