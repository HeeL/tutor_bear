class NotifierMailer < ActionMailer::Base
  default from: 'no-reply@tutorbear.net'
  default to: ENV['NOTIFY_EMAILS'].split(',')
 
  def new_comment(cmt)
    @post = cmt.commentable
    @cmt_text = cmt.text
    mail(subject: "[TutorBear] New comment to an Article")
  end
end