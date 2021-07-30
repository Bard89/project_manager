class ProjectsController < ApplicationController
    # here we code all the actions for which we created the routes rb
    
    # since I'll see just my projects, and there will be no cooperation between
    # maybe I can ise the current user as a "validation" here and don't have to create new controleer profiles
    # as we have done in the local shopper


    # I'll just do the crud for all rpjects not for one specific user here, for practice
    # to see all the projects
    def index
        @projects = Project.all #tahle vidim vsechny projekty bez ohledu na to za jakyho usera jsem nalogovanej 
    end

    # to show one restaurant
    def show
        @project = Project.find(params[:id])
    end

    # just need an empty instance just to initialise it
    def new
        @project = Project.new
    end

    def create
        # @project = Project.new(params[:project]) #I'd get forbidden attributes
        #    error(in the browser), because it's not safe enough like this, someone can hack it
        # we fix it with strong params in the private method at the bottom of the actions
        @project = Project.new(project_params)
        @project.user_id = current_user.id # need to specify the id, is not authomatic here whoat?
        @project.save
        # for the redirect I go to my roots in terminal and check the prefix
        # then copy it and add _path to it
        # then check if I have a dynamic value in there -> id
        # I have here, so I put @project there, which for rails is the same as @project.id
        redirect_to project_path(@project)
    end
    
    def edit

    end

    def update
    end

    def destroy
    end
    
    private

    # so called strong params
    def project_params
        # require mean that I wanna require the key inside, disregard all the other keys
        # inside the permitted key just take the :title and :position, nothing else
        params.require(:project).permit(:title, :position)
    end
end
