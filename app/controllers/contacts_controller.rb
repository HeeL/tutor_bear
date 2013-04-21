class ContactsController < ApplicationController

  before_filter :user_signed_in, :check_receiver, :check_previous_contact
  
  def send_contacts
    info = {
      from: current_user,
      to: User.find(params[:send_to]),
      received_as: params[:receive_as]
    }
    ContactMailer.send("send_#{params[:receive_as]}_contacts", info).deliver
    ContactLog.log_send_contacts(info)
    result = set_success(I18n.t("contacts.sent", receiver: I18n.t("contacts.#{params[:receive_as]}")))

    render json: result
  end

  private

  def user_signed_in
    render json: set_error(I18n.t('auth_required')) unless current_user
  end

  def check_previous_contact
    previous = ContactLog.where(user_sent: current_user.id, user_received: params[:send_to], received_as: params[:receive_as]).first
    if previous
      if 7.days.ago < previous.created_at
        render json: set_error(I18n.t('contacts.already_contacted'))
      end
    end
  end

  def check_receiver
    raise 'Invalid Receiver' unless ['learner', 'teacher'].include?(params[:receive_as])
  end

end
