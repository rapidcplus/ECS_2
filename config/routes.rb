Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end
  
  resources :items
end
