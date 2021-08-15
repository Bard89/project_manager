class TasksController < ApplicationController
    before_action :find_project, only: [:index, :index_done, :index_not_done,  :new, :create, :edit]
    before_action :find_task, only: [:update_status, :update_status_done, :update_status_not_done, :update_status_show, :show, :edit, :update, :destroy, :destroy_attached_file] 
    
    def index
        #  from medium article -> https://medium.com/@bretdoucette/n-1-queries-and-how-to-avoid-them-a12f02345be5
        # The Includes method uses a concept called ‘Eager Loading.’ In our example, eager loading works by
        # preloading every comment for every article beforehand in a temporary cache stored in memory. This allows us to iterate through all 
        # the articles and call ‘.comments’ on them without having to ping the database over and over again.

        # basically I have to go through the tag_tasks, because I have many to many through association, so the joint is throuh the tag-tasks table 
        # the querry is possible to see in the server window of the terminal 
        @pagy, @tasks = pagy(policy_scope(Task.includes([:tag_tasks]).includes([:tags]).where(project_id: @project.id)))
        if params[:query].present?
            @pagy, @tasks = pagy(policy_scope(Task).includes([:tag_tasks]).includes([:tags]).search_by_title(params[:query]))
        end
    end

    def index_done
        @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: true)))
        if params[:query].present?
            @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: true)).search_by_title(params[:query]))
        end
    end

    def index_not_done
        @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: false))) 
        if params[:query].present?
            @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: false)).search_by_title(params[:query]))
        end
    end

    def update_status_show
        update_status_action
        redirect_to project_task_path(@task.project, @task)
    end

    def update_status
        update_status_action
        redirect_to project_tasks_path(@task.project)
    end

    def update_status_done
        update_status_action
        redirect_to index_done_project_tasks_path(@task.project)
    end

    def update_status_not_done
        update_status_action
        redirect_to index_not_done_project_tasks_path(@task.project)
    end

    def show
        @tags = Tag.where(user_id:current_user)
    end

    def new
        @task = Task.new
        authorize @task
    end

    def create
        @task = Task.new(task_params)
        @task.project = @project
        @task.user = current_user
        authorize @task
        
        if @task.save || params[:task][:tag_ids] # && @task.update(task_params) 
            @task.tag_ids = params[:task][:tag_ids]
            flash[:success] = "Task successfully created"
            redirect_to project_task_path(@project, @task)
        else
            flash.now[:error] = "Something went wrong"
            render 'new'
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)# || params[:task][:tag_ids]
            # @task.tag_ids = params[:task][:tag_ids]

            # new from simple form


            flash[:success] = "Task was successfully updated"
            redirect_to project_task_path(@task.project, @task)
        else
            flash[:error] = "Something went wrong"
            render 'edit'
        end
    end

    def destroy
        @task.destroy
        flash[:success] = "Task was successfully deleted"
        redirect_to project_tasks_path(@task.project)
    end

    def destroy_attached_file
        if !@task.file.purge # this returns nil but it deletes the file attachement
            flash[:success] = "File successfully deleted"
            redirect_to edit_project_task_path(@task.project, @task)
        else
            flash[:error] = "Can't delete file, no file attached"
            redirect_to edit_project_task_path(@task.project, @task)
        end
    end
    
    private

    def find_project
        @project = Project.find(params[:project_id])
    end

    def find_task
        @task = Task.find(params[:id])
        authorize @task
    end

    def task_params
        params.require(:task).permit(:title, :description, :is_done, :file, :remove_file)
    end

    def tag_params
        params.require(:tag).permit(:title)
    end

    def update_status_action
        @task.is_done ? @task.update(is_done: false) : @task.update(is_done: true)
    end
end
