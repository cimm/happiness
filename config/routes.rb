Rails.application.routes.draw do
  get '/auth/google_oauth2/callback' => 'sessions#create'
  resources :questions, expect: [:show, :destroy]
  root to: 'home#index'
end
