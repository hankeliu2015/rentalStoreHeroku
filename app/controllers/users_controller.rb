class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :show


  def show
    # use current_user to replace user id in URL. repalce all @user with current_user

      @in_prossession = current_user.rentals.in_possession
      #binding.pry
      @scheduled_rentals = current_user.rentals.scheduled_rentals
      @overdue_items = current_user.rentals.overdue
      @past_rented_tools = current_user.rentals.past_rentals
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
