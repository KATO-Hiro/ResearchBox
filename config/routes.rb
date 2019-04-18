Rails.application.routes.draw do
  root 'static_pages#home'
  get '/posts', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }
  resources :users, only: [:index, :show]
  resources :posts, only: [:show, :new, :edit, :update, :create, :destroy] do
    resources :stocks, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
end
