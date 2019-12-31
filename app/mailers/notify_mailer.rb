class NotifyMailer < ApplicationMailer
  def notification(user)
    @user = user
    mail(
      from: @user.email,
      to:"hanke.liu@gmail.com",
      content_type: "text/plain",
      subject: "Welcome #{{@user.name}} Register at Rental Store"
    )
  end
end
