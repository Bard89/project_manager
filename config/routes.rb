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
  
    end

end
