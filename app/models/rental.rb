class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  def self.past_tool_rental(tool, user)

    @past_rental = where(tool_id: tool.id, user_id: user.id).where(return: true)

    @past_rental[0].return_date if @past_rental != [] #???
  end

end #end of class
