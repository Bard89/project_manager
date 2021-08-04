class TagPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user).order(position: :asc) # don't have to do user_id: user.id, i guess it takes the id parameter fro mthe user on its own
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
