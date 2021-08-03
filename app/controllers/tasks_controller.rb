class TasksController < ApplicationController
    before_action :find_project, only: [:index, :new, :create, :edit]
    before_action :find_task, only: [:show, :edit, :update, :destroy] 
    
    def index # index for all the tasks of one project
        @tasks = Task.where(user_id: current_user, project_id: @project.id)
        authorize @tasks
    end

    def show
        # here is z.B. the question of authorisation or so, user could go to whichever project he wishes
        #@task = Task.find(params[:id])
        # bellow is not suitable here, because I wanna show just one task -. I need authorisation
        #@tasks = Task.where(user_id: current_user, project_id: @project.id, id:params[:id])
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
    
    def edits
        #find_project by tu mel byt, pokud, bych ho pouzil v simple_form
        # v simple_form ale pouzivam @task.project, proto to tu nepotrebuji, ale pozor
        # tohle muze breakovat !!!

        #when I moved the fomr to the _form, then it's for new and edit action, then i need the @project
        # cause in the new action is no @task.project yet
    end

    def update
        @task.update(task_params)
        # redirect_to project_task_path(@task.project, @task)
        redirect_to project_task_path(@task.project, @task)
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
