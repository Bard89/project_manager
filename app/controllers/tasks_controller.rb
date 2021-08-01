class TasksController < ApplicationController
    before_action :find_project, only: [:index, :new, :create]
    before_action :find_task, only: [:show] # if only once, maybe it can be directly in the action once ... 
    def index
        @tasks = Task.where(user_id: current_user)
    end

    def show
        #@task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        # bellow -> it says that the project of the task is project that I have acess to right now, so the association/connection is created between task and a project
        @task.project = @project # since task belong to project, I have to say this, so it's associated woth a project always
        @task.user = current_user
        if @task.save
          flash[:success] = "Task successfully created"
          redirect_to project_task_path(@project, @task) # if I have 2 dynamic values/ids, then I put it in like this
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end
    
    def edit
    end

    def update
    end

    def destroy
    end
    
    private
    def find_project
        @project = Project.find(params[:project_id])
    end

    def find_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:title, :description, :is_done)
    end
end
