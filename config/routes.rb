Rails.application.routes.draw do
  get '/auth/google_oauth2/callback' => 'sessions#create'
  resources :questions, expect: [:destroy]
  resources :users, only: [:index, :new, :create, :update, :destroy]
  resources :settings, only: [:index]
  resources :surveys, only: [] do
    resources :batch_answers, controller: 'surveys/batch_answers', only: [:new, :create]
    resource :completed, controller: 'surveys/completed', only: [:show]
  end
  root to: 'home#index'
end
