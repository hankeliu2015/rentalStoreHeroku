class ToolSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :rentals
end
