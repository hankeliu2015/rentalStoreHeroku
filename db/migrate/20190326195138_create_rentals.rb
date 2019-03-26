class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.datetime :start_date
      t.datetime :return_date
      t.boolean :return
      t.references :user, foreign_key: true
      t.references :tool, foreign_key: true

      t.timestamps
    end
  end
end
