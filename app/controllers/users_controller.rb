class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :show


  def show
    # use current_user to replace user id in URL. repalce all @user with current_user

      @in_prossession = current_user.rentals.rentals_in_progress
      # binding.pry
      @scheduled_rentals = current_user.rentals.scheduled_rentals

      @overdue_items = current_user.rentals.overdued
      # the following code no needed. User show only only show a link for completed_rentals.
      # @past_rented_tools = current_user.rentals.completed_rentals
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
