Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "employees#index"

  get "/increment" => "employees#increment"
  get "/decrement" => "employees#decrement"
  get "/results" => "employees#results"
  
  resources :employees
end
