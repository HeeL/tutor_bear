class FeedbacksController < ApplicationController

  def send_feedback
    info = {
      from: current_user ? current_user.email : params[:from],
      text: params[:text]
    }
    FeedbackMailer.send_feedback(info).deliver
    result = set_success("#{I18n.t('email_sent')} #{ENV['INFO_EMAIL']}")

    render json: result
  end
  
end