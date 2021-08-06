class TagsController < ApplicationController

    before_action :find_tag, only: [:show, :edit, :update, :destroy]

    def index
        @tags = policy_scope(Tag)
    end

    def new
        @tag = Tag.new
        authorize @tag
    end

    def create
        @tag = Tag.new(tag_params)
        @tag.user_id = current_user.id
        authorize @tag
        if @tag.save
            flash[:success] = "Tag successfully created"
            redirect_to tags_path
        else
            flash[:error] = "Something went wrong"
            render 'new' 
        end
    end
    
    def edit
    end

    def update
        if @tag.update(tag_params)
            flash[:success] = "Object was successfully updated"
            redirect_to tags_path
        else
            flash[:error] = "Something went wrong"
            render 'edit'
        end
    end

    def destroy
        @tag.destroy
        redirect_to tags_path
    end

    def add_tag_to_task
        
    end
    
    private

    def tag_params
        params.require(:tag).permit(:title)
    end

    # don't wanna write the find parmas many times, jsut create a method so we don't repeat ourselves
    # then i say I run it before some of the actions
    def find_tag
        @tag = Tag.find(params[:id])
        authorize @tag
    end


end