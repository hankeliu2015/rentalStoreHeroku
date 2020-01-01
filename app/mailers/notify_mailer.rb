class NotifyMailer < ApplicationMailer
  def rental_confirmation(rental)
    @rental = rental
    @tool = rental.tool
    @user = rental.user
    mail(
      to: @user.email,
      # content_type: "text/plain",
      subject: "Thanks #{@user.username} for renting #{@tool.name}"
    )
  end

  def return_reminder(rental)
    @rental = rental
    @tool = rental.tool
    @user = rental.user
    mail(
      to: @user.email,
      # content_type: "text/plain",
      subject: "The tool #{@tool.name} you rented is due tomorrow. Please renew or return"
    )
  end


end
