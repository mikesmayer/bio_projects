Rails.application.routes.draw do
  get 'static/index'
  root 'static#index'

  resources :projects, only: [:index, :update, :show, :destroy]
  resources :runs, except: [:create]
  resources :read_groups, except: [:create] do
    post 'entity', to: 'entity#destroy_all'
  end
end
