Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "employees#index"
  
  resources :employees do
    collection do
      get "increment"
      get "decrement"
      get "results"
    end
  end
end
