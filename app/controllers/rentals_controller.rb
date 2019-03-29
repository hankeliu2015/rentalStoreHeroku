class RentalsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @rental = Rental.new(tool_id: params[:tool_id])
  end

  def create
    #binding.pry
    rental = Rental.new(rental_params)
    rental.save

    redirect_to user_path(rental.user) #leave it to root for now.
  end

  def update

  end

  private
  def rental_params
    params.require(:rental).permit(:user_id, :tool_id, :start_date, :return_date, :return)
  end
end
