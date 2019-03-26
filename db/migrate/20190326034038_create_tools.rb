class CreateTools < ActiveRecord::Migration[5.2]
  def change
    create_table :tools do |t|
      t.string :name
      t.string :type
      t.string :brand
      t.string :description
      t.string :condition
      t.boolean :availability

      t.timestamps
    end
  end
end
