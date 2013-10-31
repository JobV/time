Jxtime::Application.routes.draw do
  mount JasmineRails::Engine => "specs" if defined?(JasmineRails)

  devise_for :users

  resources :timers

  # get 'timers/:id/starting_time' => 'timers#starting_time', as: :starting_time

  post 'timers/start' => 'timers#start', as:  :start_timer
  post 'timers/:id'  => 'timers#stop', as:   :stop_timer

  get 'settings' => 'settings#index', as: :settings

  root to: 'timers#index'
end
