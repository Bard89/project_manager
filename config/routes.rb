Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  # we need to define the routes for CRUD (and other) actions here
  # we use the resources instead of individually typing the routes ourselves
  # resources :users do # should it be nested?
    resources :projects do # creates the routes for all the crud
      # if I don't need all the crud action, I can pick just some, with only or except
  end
end
