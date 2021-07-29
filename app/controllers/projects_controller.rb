class ProjectsController < ApplicationController
    # here we code all the actions for which we created the routes rb
    
    # to see all the projects
    def index
        @projects = Project.all
    end

    def def show
    end

    def new
    end

    def create
        # @object = Object.new(params[:object])
        # if @object.save
        #   flash[:success] = "Object successfully created"
        #   redirect_to @object
        # else
        #   flash[:error] = "Something went wrong"
        #   render 'new'
        # end
    end
    
    def edit
    end

    def update
    end

    def destroy
    end
    
end
