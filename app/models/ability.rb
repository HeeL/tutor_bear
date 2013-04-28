class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new
    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :manage, Post
    elsif user.read_only?
      can :read, :all
    end
  end

end
