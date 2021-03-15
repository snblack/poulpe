Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: :login, sign_out: :logout}

  root to: "products#index"

  resources :products do
    resources :keywords, shallow: true
    resources :variances, shallow: true, only: :show
  end

  resources :positions, only: :create
  resources :snapshots, only: :create
  resources :variances, only: :index
end
