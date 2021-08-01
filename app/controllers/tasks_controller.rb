class TasksController < ApplicationController
    before_action :find_project, only: [:index, :new, :create]
    before_action :find_task, only: [:show, :edit, :update, :destroy] 
    
    def index # index for all the tasks of one project
        @tasks = Task.where(user_id: current_user, project_id: @project.id)
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
        # the if else statement basically does for us that when we don't pass the validations
        # the user get another chance to fix that, to put it there again
        if @task.save # returns true or false
          flash[:success] = "Task successfully created"
          redirect_to project_task_path(@project, @task) # if I have 2 dynamic values/ids, then I put it in like this
        else
          flash[:error] = "Something went wrong"
          render 'new' # we display the template of the new page, we display what failed to save, simple_form handles that
        end
    end
    
    def edit
    end

    def update
        @task.update(task_params)
        redirect_to project_task_path(@task)
    end

    def destroy
        @task.destroy
        redirect_to project_path(@task.project)
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
