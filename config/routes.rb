Rails.application.routes.draw do
  get 'thanks/index'
  # devise_for :users
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  resources :users
  resources :floors
  resources :forms
  resources :thanks
  root 'home#home'

  # devise_for :users,
  #            controllers: {
  #                sessions: 'users/sessions',
  #                registrations: 'users/registrations'
  #            }

  # get '/member-data', to: 'members#show'

  # get '*path', :to => 'application#routing_error'
  # post '*path', :to => 'application#routing_error'

  # if wrong route given
  get '*path', to: 'application#routing_error'
  post '*path', to: 'application#routing_error'
  # ---------------------------

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
