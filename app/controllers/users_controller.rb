class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :show


  def show

      @in_prossession = current_user.rentals.in_progress

      @scheduled_rentals = current_user.rentals.scheduled

      @forget_checkout = current_user.rentals.forget_checkout

      @overdue_items = current_user.rentals.overdued

      @aday_before_return_rentals = current_user.rentals.aday_before_return

      if @aday_before_return_rentals
        @aday_before_return_rentals.each do |rental|
          NotifyMailer.return_reminder(rental).deliver_now
        end
      end

      @user = current_user #use @user to render serializer.

      respond_to do |f|
        f.html {render :show}
        f.json {render json: @user }
      end

      # render json: @user.to_json
      # render json: @user

  end

  # use current_user to replace user id in URL. repalce all @user with current_user

  def user_monthly_report
    # raise params.inspect
    @user = current_user
    @rentals = @user.rentals.past30days_rentals
    # if @rentals
    #   flash[:success] = "Successfully generated User's monthly Rental Report"
    # end
    NotifyMailer.monthly_report(@rentals, @user).deliver_now
    redirect_to :root
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
