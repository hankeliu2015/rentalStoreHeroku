class AddCategoryToTools < ActiveRecord::Migration[5.2]
  def change
    add_column :tools, :category, :string
  end
end
