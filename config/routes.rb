Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  get "/destination/list", to: "destination#list"
  get "/destination/search", to: "destination#search"

  resources :session
  resources :user
  resources :trip
  resources :destination
end
