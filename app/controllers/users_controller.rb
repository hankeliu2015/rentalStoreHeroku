class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :show


  def show

      @in_prossession = current_user.rentals.in_progress

      @scheduled_rentals = current_user.rentals.scheduled

      @forget_checkout = current_user.rentals.forget_checkout

      @overdue_items = current_user.rentals.overdued

      @user = current_user #use @user to render serializer. 

      respond_to do |f|
        f.html {render :show}
        f.json {render json: @user }
      end

      # render json: @user.to_json
      # render json: @user

  end

  # use current_user to replace user id in URL. repalce all @user with current_user

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
