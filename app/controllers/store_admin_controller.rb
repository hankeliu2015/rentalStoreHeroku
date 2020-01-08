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

    flash[:alert] = "Monthly Email report is sent to all users."
    redirect_to store_admin_dashboard_path
  end

  def aday_return_reminder
    @aday_before_return_rentals = Rental.aday_before_return

    if @aday_before_return_rentals
      @aday_before_return_rentals.each do |rental|
        NotifyMailer.return_reminder(rental).deliver_now
      end
    end

    flash[:alert] = "Monthly Email report is sent to all users."
    redirect_to store_admin_dashboard_path
  end

  def api_welcome_message
    @user = current_user
    RestClient.post "https://api:#{ENV["MAILGUN_APIKEY"]}"\
    "@api.mailgun.net/v3/#{ENV["MAILGUN_DOMAIN"]}/messages",
    :from => "#{@user.username} <mailgun@#{ENV["MAILGUN_DOMAIN"]}>",
    :to => "#{@user.email}",
    :subject => "Welcome Message Testing",
    :text => "Hi, Testing some Mailgun awesomness!"

    flash[:alert] = "Welcome email send to #{@user.username}."
    redirect_to store_admin_dashboard_path

  end

end
