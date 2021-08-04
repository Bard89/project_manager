class TagsController < ApplicationController
    def index
        raise
        @tasks = policy_scope(Task.where(project_id: @project.id))
    end
end
