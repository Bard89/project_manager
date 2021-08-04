class TagPolicy < ApplicationPolicy
  class Scope < Scope
    raise
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user)#.order(position: :asc)
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

end
