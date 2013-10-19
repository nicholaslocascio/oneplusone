Oneplusone::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :organizations

  get 'signup', to: 'organizations#new', as: 'signup'
  post 'signup', to: 'organizations#create', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root :to => 'organizations#home'

  # See how all your routes lay out with "rake routes"
end