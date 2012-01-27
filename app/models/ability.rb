class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    
    if user.role? :superadmin
      can :manage, :all
    else
      can :read, Person 
      if user.role? :admin
        can :read, :all
        can :manage, Person
        can :manage, Organization
        can :manage, University
        can :manage, Religion
      end
    end
  end
end