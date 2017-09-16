Rails.application.routes.draw do
  resource :index, only: :show
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]

  namespace :account do
    resources :incomes, only: [:index, :create, :update, :destroy]
    resources :expenses, only: [:index]
    resources :random_expenses, only: [:index, :create, :update, :destroy]
    resources :recurrent_expenses, only: [:index, :edit, :create, :update, :destroy]

    root to: 'random_expenses#index'
  end

  root to: 'index#show'
end
