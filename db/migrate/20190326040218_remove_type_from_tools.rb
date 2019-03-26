class RemoveTypeFromTools < ActiveRecord::Migration[5.2]
  def change
    remove_column :tools, :type, :string
  end
end
