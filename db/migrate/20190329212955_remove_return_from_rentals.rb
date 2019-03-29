class RemoveReturnFromRentals < ActiveRecord::Migration[5.2]
  def change
    remove_column :rentals, :return, :boolean
  end
end
