class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :show


  def show
    # use current_user to replace user id in URL
    # if current_user.id != @user.id
    #   flash[:alert] = "You can not access other user's profile. Here is the information under your profile"
    #   @user = current_user #make sure @user consistancy in show.html.erb
    # end
      # @in_progress = @user.rentals.in_progress
      @in_prossession = current_user.rentals.in_possession
      @scheduled_rentals = current_user.rentals.scheduled_rentals
      @overdue_items = current_user.rentals.overdue
      @past_rented_tools = current_user.rentals.past_rentals
#binding.pry
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
