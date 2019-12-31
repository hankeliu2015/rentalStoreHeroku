class NotifyMailer < ApplicationMailer
  def notification(rental)
    @rental = rental
    @tool = rental.tool
    @user = rental.user
    mail(
      from: storeappnotifier@gmail.com,
      to: @user.email,
      content_type: "text/plain",
      subject: "Thanks #{{@user.name}} for renting #{{@tool}}"
    )
  end
end
