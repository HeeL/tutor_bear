class FeedbackMailer < ActionMailer::Base
  default from: 'no-reply@tutorbear.net'

  def send_feedback(info)
    @info = info
    mail(to: ENV['INFO_EMAIL'], subject: "[TutorBear] Feedback from a user")
  end

end