Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root 'projects#dashboard', as: :authenticated_root 
  end

  root to: 'pages#home'

  get '/dashboard', to: 'projects#dashboard'

  resources :projects do 
    resources :tasks, except: [:destroy] do
      collection do
        get :index_done
        get :index_not_done
      end
    end
  end
  resources :tasks, only: [:destroy]
  resources :profiles, only: [:show]
  resources :tags, except: [:show] 
end
