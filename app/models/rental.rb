class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :tool


  def self.overdue #no need the argument(user). chain this method after @user.retnals ActiveRecord::Relation object
    where("return_date < ?", Date.today).where(return: false) #where(user_id: user.id) can be done in users controller show
  end

  def self.past_tool_rental(tool, user)

    @past_rental = where(tool_id: tool.id, user_id: user.id).where(return: true)

    #@past_rental[0].return_date if @past_rental != [] #???
  end

end #end of class
