class StoreAdminController < ApplicationController
  def dashboard
    @users = User.all
    @tools = Tool.all
  end

  def email_monthly_report
    # binding.pry
    User.all.each do |user|
      @user = user
      @rentals = @user.rentals.past30days_rentals
      NotifyMailer.monthly_report(@rentals, @user).deliver_now
    end
    
    flash[:alert] = "Monthly Eamil report is sent to all users."
    redirect_to store_admin_dashboard_path
  end
end
