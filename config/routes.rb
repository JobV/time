Jxtime::Application.routes.draw do
  devise_for :users

  resources :timers

  # get 'timers/:id/starting_time' => 'timers#starting_time', as: :starting_time

  post 'timers/start' => 'timers#start', as:  :start_timer
  post 'timers/stop'  => 'timers#stop', as:   :stop_timer

  root to: 'timers#index'
end
