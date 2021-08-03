class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user) # unfortunatelly I can't inser # Task.where(project_id: @project.id # here
    end
  end

  def create?
    true
  end

  def show?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
