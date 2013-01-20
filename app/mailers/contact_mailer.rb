class ContactMailer < ActionMailer::Base
  default from: 'no-reply@tutorbear.net'
 
  def send_learner_contacts(info)
    @info = info
    mail(to: info[:to].email, subject: "[TutorBear] Learner sent you his contact details")
  end

  def send_teacher_contacts(info)
    @info = info
    mail(to: info[:to].email, subject: "[TutorBear] Teacher sent you his contact details")
  end

end