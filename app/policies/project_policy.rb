class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve # for index method (dashboard for this app)
      #scope.all # means the same (for the Project) as Project.all -> it says all of the Projects to be displayed to the user
      # for the index (here dashboadr method)
      if user.admin?
        scope.all
      else
        scope.where(user_id: user).order(position: :asc) # don't have to do user_id: user.id, i guess it takes the id parameter fro mthe user on its own
      end
    end
  end

  # asks the create method -> don't need the new here
  # def new?
  #   true
  # end

  def create?
    true
  end

  def show?
    user_is_owner_or_admin?
  end

  # but for example edit shouldn't nbe true by default
  # we only want that the one that created the instance is is able to change it
  
  # def edit?
    # if the user is the owner 
      # then true
    
    # can't use current user here, in ,my application policy is defined just user and record (record is what we pass in in the authorize @record)
    # true if @project.user_id == current_user

    # user => current_user
    # record => @project
    # true if @record.user_id == @user.id # we don't have to use the @, but it would still worked
    # record.user_id == user.id # returns true or false, I put it just in update, cause update calls the edit in applications policy
  # end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.user == user || user.admin
  end

end
