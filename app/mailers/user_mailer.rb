class UserMailer < ActionMailer::Base
  default from: "Bluesmart <welcome@bluesmart.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "I've gained early access to the new @bluesmart suitcase launch. Check it out here "

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
