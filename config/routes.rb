Rails.application.routes.draw do
  get '/auth/google_oauth2/callback' => 'sessions#create'
  root to: 'home#index'
end
