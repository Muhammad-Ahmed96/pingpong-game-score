Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "home#index"
  get ':id/history', to: 'home#history', as: :game_history
  get '/log',     to: 'home#log'
  post '/log',    to: 'home#log_create', as: :log_create
end
