class UserSerializer < ActiveModel::Serializer
  attributes :id, :returned_rentals
  has_many :rentals
end
