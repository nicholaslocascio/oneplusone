Oneplusone::Application.routes.draw do

  resources :people


  resources :teams
  resources :organizations
  resources :password_resets
  

  get 'signup', to: 'organizations#new', as: 'signup'
  post 'signup', to: 'organizations#create', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  post 'teams/:id/add_person/:person_id', to: 'teams#add_person', as: 'add_person_to_team'
  post 'teams/:id/remove_person/:person_id', to: 'teams#remove_person', as: 'remove_person_from_team'


  root :to => 'organizations#home'

end