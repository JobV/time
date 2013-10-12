Jxtime::Application.routes.draw do
  devise_for :users

  resources :timers
  post 'timers/start' => 'timers#start', as:  :start_timer
  post 'timers/stop'  => 'timers#stop', as:   :stop_timer

  root to: 'timers#index'
end
