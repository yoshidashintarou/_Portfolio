Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


   root 'users#new'

  resources :users, except: [:index] do
    member do
      get :activate
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:create, :edit, :update]

  get 'signup'  => 'users#new',        as: 'signup'
  get 'login'   => 'sessions#new',     as: 'login'
  get 'logout'  => 'sessions#destroy', as: 'logout'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
end

