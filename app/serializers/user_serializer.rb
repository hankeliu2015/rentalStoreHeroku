class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :returned_rentals
  has_many :rentals
end
