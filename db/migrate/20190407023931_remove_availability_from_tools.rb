class RemoveAvailabilityFromTools < ActiveRecord::Migration[5.2]
  def change
    remove_column :tools, :availability, :boolean
  end
end
