Jxtime::Application.routes.draw do
  devise_for :users

  resources :timers

  root to: 'timers#index'
end
