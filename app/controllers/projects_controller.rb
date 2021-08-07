class ProjectsController < ApplicationController
    
    before_action :find_project, only: [:show, :edit, :update, :destroy] # to be able to use the private method of find_project, so we don't repeat ourselves
    
    # here we code all the actions for which we created the routes rb
    
    # since I'll see just my projects, and there will be no cooperation between
    # maybe I can ise the current user as a "validation" here and don't have to create new controleer profiles
    # as we have done in the local shopper


    # I'll just do the crud for all rpjects not for one specific user here, for practice
    # to see all the projects
    def dashboard # index changed to dashboard, all the projects of logged in user
        # IMP IMP we'll have to do somethign like this, cause we don't wanna see all projects, but always from specific user
        # Project.where(user_id:current_user)

        # projekty radim podle navoleny pozice# tohle potom udelam pres pundit
        
        # here we authorise the @projects instance, and then in the project_policy.rb we say which users should be able to see the @projects
        #authorize @projects #it's different to all of the other actions, because I have authorised not one action but all actions
        # so we use

        # the pagy just saves it all in pagy, what I had before
        @pagy, @projects = pagy(policy_scope(Project)) # will look inside of our project_policy.rb and will look to the scope in the beginning
        #@projects = policy_scope(Project)
        # in the project_policy added dashboard aside from index



        # @search = params["search"]
        # if @search.present?
        #     @title = @search["title"]
        #     @projects = @projects.where("title ILIKE ?", "%#{@title}%")
        # end
        
        if params[:query].present?
            @projects = Project.search_by_title(params[:query])
        end

    end

    # to show one restaurant
    def show
        # @project = Project.find(params[:id])
    end

    # just need an empty instance just to initialise it
    def new
        @project = Project.new
        authorize @project
    end

    def create
        # @project = Project.new(params[:project]) #I'd get forbidden attributes
        #    error(in the browser), because it's not safe enough like this, someone can hack it
        # we fix it with strong params in the private method at the bottom of the actions
        @project = Project.new(project_params)
        @project.user_id = current_user.id # need to specify the id, is not authomatic here whoat?
        authorize @project
        # for the redirect I go to my roots in terminal and check the prefix
        # then copy it and add _path to it
        # then check if I have a dynamic value in there -> id
        # I have here, so I put @project there, which for rails is the same as @project.id
        
        # we use the redirect when we have no view for the action, cause user has to see soemthing right
        if @project.save
            flash[:success] = "Project successfully created"
            redirect_to project_path(@project)
        else
            flash[:error] = "Something went wrong"
            render 'new' 
        end
    end
    
    # that's just a way to find and be able to see the edit of the project, it's not saving or updating is ASIO
    # basically just for the view, so the user can see what he wants to update 
    
    def edit
        # in the view, there is from the form helper even can see on the button to have update the project
        # so we usee the update action to update the project
        # @project = Project.find(params[:id])
    end

    def update
        # @project = Project.find(params[:id])
        if @project.update(project_params) # I'll take the value from the form again
            flash[:success] = "Object was successfully updated"
            redirect_to project_path(@project)
        else
            flash[:error] = "Something went wrong"
            render 'edit'
        end
    end

    def destroy
        #@project = Project.find(params[:id])
        @project.destroy
        redirect_to dashboard_path
    end
    
    private

    # so called strong params
    def project_params
        # require mean that I wanna require the key inside, disregard all the other keys
        # inside the permitted key just take the :title and :position, nothing else
        params.require(:project).permit(:title, :position)
    end

    # don't wanna write the find parmas many times, jsut create a method so we don't repeat ourselves
    # then i say I run it before some of the actions
    def find_project
        @project = Project.find(params[:id])
        authorize @project # I put it here so I don't have to put it in every method one by one
    end
end
