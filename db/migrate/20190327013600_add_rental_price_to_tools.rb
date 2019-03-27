class AddRentalPriceToTools < ActiveRecord::Migration[5.2]
  def change
    add_column :tools, :rental_price, :integer
  end
end
