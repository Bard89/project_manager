class ApplicationPolicy
  attr_reader :user, :record # we have user and argument passed to the authorise method, so e.g. 
  # authorize @project, then @project is the :record here

  def initialize(user, record)
    @user = user
    @record = record
  end

  # all of these acions will return a boolean
  # these are the native actions of pundit for actions, I can redefine it in the z.B. project_policy.rb
  def dashboard? # added, since I have dashboard instead of index
    false
  end
  
  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
