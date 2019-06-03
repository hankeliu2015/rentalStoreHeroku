class ToolSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :description, :condition, :rental_price, :image, :rental_in_progress
  has_many :rentals

end
