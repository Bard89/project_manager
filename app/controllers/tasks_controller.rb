class TasksController < ApplicationController
    before_action :find_project, only: [:index, :index_done, :index_not_done,  :new, :create, :edit]
    before_action :find_task, only: [:update_status, :update_status_show, :show, :edit, :update, :destroy] 
    
    def index
        @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id)))
        if params[:query].present?
            @pagy, @tasks = pagy(policy_scope(Task).search_by_title(params[:query]))
        end
    end

    def index_done
        @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: true))) # takhle to vytridi ale pstatni to mohou porad editovat kdyz chteji
        if params[:query].present?
            @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: true)).search_by_title(params[:query]))
        end
    end

    def index_not_done
        @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: false))) # takhle to vytridi ale pstatni to mohou porad editovat kdyz chteji
        if params[:query].present?
            @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: false)).search_by_title(params[:query]))
        end
    end

    def update_status
        @task.is_done ? @task.update(is_done: false) : @task.update(is_done: true)
        redirect_to project_tasks_path(@task.project)
    end

    def update_status_show
        @task.is_done ? @task.update(is_done: false) : @task.update(is_done: true)
        redirect_to project_task_path(@task.project, @task)
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
        if @task.save && @task.update(task_params) && @task.tag_ids = params[:task][:tag_ids]
            flash[:success] = "Task successfully created"
            redirect_to project_task_path(@project, @task)
        else
            flash[:error] = "Something went wrong"
            render 'new'
        end
    end

    def edit
    end

    def update
        
        if @task.update(task_params) && @task.tag_ids = params[:task][:tag_ids]
            flash[:success] = "Object was successfully updated"
            redirect_to project_task_path(@task.project, @task)
        else
            flash[:error] = "Something went wrong"
            render 'edit'
        end
    end

    def destroy
        @task.destroy
        redirect_to project_tasks_path(@task.project)
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
        params.require(:task).permit(:title, :description, :is_done)
    end

    def tag_params
        params.require(:tag).permit(:title)
    end
end
