class RentalSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :return_date
end
