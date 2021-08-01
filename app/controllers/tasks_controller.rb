class TasksController < ApplicationController
    before_action :find_project, only: [:new, :create]

    # def index
    #     @tasks = Tasks.all
    # end

    # def show
    # end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        @task.project = @project # since task belong to project, I have to say this, so it's associated woth a project always
        if @task.save
          flash[:success] = "Task successfully created"
          #redirect_to @task
          redirect_to project_path(@project)
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
        
    end
        
    private
    def find_project
        @project = Project.find(params[:project_id])
    end

    def task_params
        params.require(:task).permit(:title, :description)
    end
end
