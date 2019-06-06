class RentalSerializer < ActiveModel::Serializer
  attributes :id, :tool_id, :start_date, :return_date
  belongs_to :tool
  belongs_to :user, serializer: UserReturnedRentalsSerializer
end
