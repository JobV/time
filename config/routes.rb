Jxtime::Application.routes.draw do
  mount JasmineRails::Engine => "specs" if defined?(JasmineRails)

  devise_for :users

  resources :timers
  resources :projects

  # get 'timers/:id/starting_time' => 'timers#starting_time', as: :starting_time

  post 'timers/start' => 'timers#start', as:  :start_timer
  post 'timers/:id'  => 'timers#stop', as:   :stop_timer

  get 'settings' => 'settings#index', as: :settings
  patch 'user/update_email' => 'settings#update_email'

  patch 'user/update_password' => 'settings#update_password'

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  root to: 'timers#index'
end
