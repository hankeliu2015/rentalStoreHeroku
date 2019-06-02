class ToolSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :description, :condition, :rental_price, :image
  has_many :rentals
end
