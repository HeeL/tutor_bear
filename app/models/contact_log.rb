class ContactLog < ActiveRecord::Base

  attr_accessible :user_sent, :user_received, :received_as

  private 

  def self.log_send_contacts(info)
    self.create(user_sent: info[:from].id, user_received: info[:to].id, received_as: info[:received_as])
  end

end