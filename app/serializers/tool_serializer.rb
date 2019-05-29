class ToolSerializer < ActiveModel::Serializer
  attributes :id
  has_many :rentals
end
