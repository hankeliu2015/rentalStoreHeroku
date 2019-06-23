class ToolSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :description, :condition, :rental_price, :image, :rental_in_progress, :rental_overdued, :rentals_scheduled, :rentals_completed
  has_many :rentals

end
