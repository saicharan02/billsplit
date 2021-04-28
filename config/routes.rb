Rails.application.routes.draw do
  root :to => 'bills#new'


  resources :sessions, :only => [:create, :destroy, :new]
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  resources :bills

  resources :users, :except => [:destroy, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
