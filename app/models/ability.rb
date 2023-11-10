class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here.
    can :read, :all

    return unless user.present?

    can :create, [Post, Comment]
    can :manage, Post, author_id: user.id
    can :manage, Comment, user_id: user.id

    return unless user.admin?
    can :manage, :all # finally we give all remaining permissions only to the admins
  end
end
