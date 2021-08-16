class TasksController < ApplicationController
    before_action :find_project, only: [:index, :index_done, :index_not_done, :new, :create, :edit]
    before_action :find_task, only: [:update_status, :update_status_done, :update_status_not_done, :update_status_show, :show, :edit, :update, :destroy, :destroy_attached_file] 
    
    def index
        @pagy, @tasks = pagy(policy_scope(Task.includes([:tag_tasks]).includes(:tags).where(project_id: @project.id))) # jenm jedno includes s :, : 
        if params[:query].present?
            @pagy, @tasks = pagy(policy_scope(Task).includes([:tag_tasks]).includes([:tags]).search_by_title(params[:query]))
        end
        # zde by sel dat param is done, not done a podle toho potom filtruji tasks
        # potom bych mel jenom jednu sablonu
    end

    def index_done # neni DRY # pridat .includes, bullet asi nevidel asociaci, potreba testovat se seeds
        @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: true)))
        if params[:query].present?
            @pagy, @tasks = pagy(policy_scope(Task.where(project_id: @project.id, is_done: true)).search_by_title(params[:query])) # tzn to sear by mel bytve stejnem kroku jako ten scope
        end
        # reseni -> ulozim si vysledek policy scope, zeptam se na querry, znvy do promeny ulozim policy scope se search a nakonci zavolam pagy
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

    def update_status # da se refactornout na to ze by to redirectlo back, nastavim tam fallback cestu 
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
        
        if @task.save || params[:task][:tag_ids]
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
        if @task.update(task_params) || params[:task][:tag_ids]
            @task.tag_ids = params[:task][:tag_ids]
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
        @task = Task.find(params[:id]) # pridam where podminku a tam dam ten current user a potom nepotrebuji pundit
        authorize @task
    end

    def task_params
        params.require(:task).permit(:title, :description, :is_done, :file, :remove_file) , #tes: :id) # vlozim hashovy klic a prazdne pole
    end

    def tag_params
        params.require(:tag).permit(:title)
    end

    def update_status_action
        @task.is_done ? @task.update(is_done: false) : @task.update(is_done: true)
    end
end
