Rails.application.routes.draw do
  get '/auth/google_oauth2/callback' => 'sessions#create'
  resources :questions, expect: [:show, :destroy]
  resources :surveys, only: [] do
    resources :batch_answers, controller: 'surveys/batch_answers', only: [:new, :create]
  end
  root to: 'home#index'
end
