class AddImageToTools < ActiveRecord::Migration[5.2]
  def change
    add_column :tools, :image, :string
  end
end
