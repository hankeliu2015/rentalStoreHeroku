class NotifyMailer < ApplicationMailer
  def notification(rental)
    @rental = rental
    @tool = rental.tool
    @user = rental.user
    mail(
      to: @user.email,
      content_type: "text/plain",
      subject: "Thanks #{@user.username} for renting #{@tool}"
    )
  end
end
