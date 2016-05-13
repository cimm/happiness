Rails.application.routes.draw do
  get '/auth/google_oauth2/callback' => 'sessions#google_oauth2'
  root to: 'home#index'
end
