class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  
  def dashboard?
    false
  end
  
  def index?
    false
  end

  #added for tasks_controller
  def index_done?
    index?
  end

  def index_not_done?
    index?
  end

  def index_multisearch?
    dashboard?
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
