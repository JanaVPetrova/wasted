Rails.application.routes.draw do
  resource :index, only: :show
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]

  namespace :account do
    resource :profile, only: [:show, :update]
    resources :incomes, only: [:index, :create, :edit, :update, :destroy]
    resources :expenses, only: [:index]
    resources :stats, only: [:index]
    resources :random_expenses, only: [:index, :create, :edit, :update, :destroy]
    resources :recurrent_expenses, only: [:index, :create, :edit, :update, :destroy]
    resources :cards, only: [:index] do
      post :sync, on: :collection

      scope module: :cards do
        resources :transactions, only: [:index] do
          post :sync, on: :collection
        end
      end
    end

    root to: 'random_expenses#index'
  end

  root to: 'index#show'
end
