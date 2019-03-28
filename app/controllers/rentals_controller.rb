class RentalsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @rental = Rental.new(tool_id: params[:tool_id])
  end

  def create
  end

  def update

  end

end
