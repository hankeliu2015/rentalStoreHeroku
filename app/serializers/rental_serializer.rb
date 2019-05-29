class RentalSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :return_date
  belongs_to :tool
end
