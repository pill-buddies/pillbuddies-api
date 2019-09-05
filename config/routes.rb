Rails.application.routes.draw do
  resources :users, only: [:show, :create]
  resources :sessions, only: [:show, :create, :destroy]
end
