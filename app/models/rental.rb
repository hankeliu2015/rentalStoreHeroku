class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :tool


  def self.overdue #no need the argument(user). chain this method after @user.retnals ActiveRecord::Relation object
    where("return_date < ?", Date.today).where(return: false) #where(user_id: user.id) can be done in users controller show
  end

  def self.past_rentals
    where(return: true)
  end

end #end of class
