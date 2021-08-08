class ProjectsController < ApplicationController
    
    before_action :find_project, only: [:show, :edit, :update, :destroy]

    def dashboard 
        @pagy, @projects = pagy(policy_scope(Project))
        if params[:query].present?
            @pagy, @projects = pagy(policy_scope(Project).search_by_title(params[:query]))
        end
    end

    # def index_multisearch
    #     @results = PgSearch.multisearch("pro")#(params[:query])
    #     skip_policy_scope
    # end

    def show
    end

    def new
        @project = Project.new
        authorize @project
    end

    def create
        @project = Project.new(project_params)
        @project.user_id = current_user.id 
        authorize @project
        if @project.save
            flash[:success] = "Project successfully created"
            redirect_to project_path(@project)
        else
            flash[:error] = "Something went wrong"
            render 'new' 
        end
    end
    
    def edit
    end

    def update
        if @project.update(project_params)
            flash[:success] = "Object was successfully updated"
            redirect_to project_path(@project)
        else
            flash[:error] = "Something went wrong"
            render 'edit'
        end
    end

    def destroy
        @project.destroy
        redirect_to dashboard_path
    end
    
    private

    def project_params
        params.require(:project).permit(:title, :position)
    end

    def find_project
        @project = Project.find(params[:id])
        authorize @project
    end
end
