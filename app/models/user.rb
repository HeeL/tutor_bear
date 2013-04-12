class User < ActiveRecord::Base
  
  devise :database_authenticatable, :validatable, :omniauthable, :rememberable, :trackable

  attr_accessible :email, :password, :name, :teach, :learn, :active,
                  :learner, :teacher, :teacher_attributes, :learner_attributes, :show_email

  has_one :teacher, dependent: :destroy
  has_one :learner, dependent: :destroy
  has_many :sent_contacts, class_name: 'ContactLog', foreign_key: :user_sent
  has_many :received_contacts, class_name: 'ContactLog', foreign_key: :user_received
  has_many :balance_histories, dependent: :destroy

  accepts_nested_attributes_for :teacher, :learner

  default_scope where(active: true)

  before_create :create_teacher_learner

  validates :name, presence: true, length: {in: 3..30}

  def self.find_fb_user(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if !user
      user = User.new(
        name: auth.extra.raw_info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0,10]
      )
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    end
    user
  end

  def self.find_google_user(data)
    auth = data.info
    user = User.where(email: auth['email']).first
    if !user
      user = User.create(
        name: auth['name'],
        email: auth['email'],
        password: Devise.friendly_token[0,10]
      )
    end
    user
  end
  
  def remember_me
    true  
  end

  def add_money(amount)
    BalanceHistory.create(amount: amount, user: self, action: 'plus')
    self.balance += amount.to_i
    self.save!
  end
  
  def sub_money(amount)
    BalanceHistory.create(amount: amount, user: self, action: 'minus')
    self.balance -= amount.to_i
    self.save!
  end

  private
  def create_teacher_learner
    self.teacher = Teacher.create unless self.teacher
    self.learner = Learner.create unless self.learner
    self.email.downcase!
  end
  
end
