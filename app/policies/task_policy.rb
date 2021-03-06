class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user).order(created_at: :desc)
      end
    end
  end

  def create?
    true
  end

  def show?
    user_is_owner_or_admin?
  end
  
  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  def destroy_attached_file?
    user_is_owner_or_admin?
  end

  def update_status?
    user_is_owner_or_admin?
  end

  def update_status_show?
    user_is_owner_or_admin?
  end

  def update_status_done?
    user_is_owner_or_admin?
  end

  def update_status_not_done?
    user_is_owner_or_admin?
  end
  private

  def user_is_owner_or_admin?
    record.user == user || user.admin
  end
end
