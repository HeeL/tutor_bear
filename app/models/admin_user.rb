class AdminUser < ActiveRecord::Base
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  def admin?
    self.role == 'admin'
  end

  def editor?
    self.role == 'editor'
  end

  def read_only?
    self.role == 'read_only'
  end

end
