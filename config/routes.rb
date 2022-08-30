Rails.application.routes.draw do
  resources :forms
  resources :floors
  # devise_for :users
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  resources :users
  resources :floors
  resources :forms
  root "home#home"

  # devise_for :users,
  #            controllers: {
  #                sessions: 'users/sessions',
  #                registrations: 'users/registrations'
  #            }


  # get '/member-data', to: 'members#show'

  # get '*path', :to => 'application#routing_error'
  # post '*path', :to => 'application#routing_error'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
