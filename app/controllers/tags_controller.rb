class TagsController < ApplicationController
    def index
        @tags = policy_scope(Tag)
    end

    # def new
    #     @project = Project.new
    #     authorize @project
    # end

    # def create
       
    #     @project = Project.new(project_params)
    #     @project.user_id = current_user.id
    #     authorize @project
    #     if @project.save
    #         flash[:success] = "Project successfully created"
    #         redirect_to project_path(@project)
    #     else
    #         flash[:error] = "Something went wrong"
    #         render 'new' 
    #     end
    # end


end