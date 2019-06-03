class RentalSerializer < ActiveModel::Serializer
  attributes :id, :tool_id, :start_date, :return_date #:in_progress
  belongs_to :tool
end
