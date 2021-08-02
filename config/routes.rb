Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  # we need to define the routes for CRUD (and other) actions here
  # we use the resources instead of individually typing the routes ourselves
  # resources :users do # should it be nested?
    resources :projects do # creates the routes for all the crud
      # if I don't need all the crud action, I can pick just some, with only or except

      # from the ADVANCED ROUTING LECTURE CCA 29TH MINUTE
      # collection -> created action in the project rout that's called top 
      # collection do
      #   get :top
      # end

      # member -> will be nested in the projects routes, collection will not
      # so i nest it but don't need a new model for it ...
      # member do
      #   get :chef
      # end
      
      # we gonna nest it, because I will wanna see it under one task when i click on it
      # because very time I create a task I want it to be associated woth the project
      # ASK but maybe I'll also do a rout not nested for the tasks?

      # rule of thumb -> only nest things that don't have their own id
        # nest [: index, :new, :create]
        # don't nest [:show, :edit, :update, :destroy]
      resources :tasks, except: [:destroy]
    end
    # outside of nesting, because I don't need an id of the project
    # the task exists already, we just destroy it, we don't wanna think about the project anymore
    # that would be redundant
    resources :tasks, only: [:destroy]

end
