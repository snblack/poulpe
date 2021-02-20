Rails.application.routes.draw do
  resources :products do
    resources :keywords, shallow: true
    resources :variances, shallow: true, only: :show
  end

  resources :positions, only: :create
  resources :snapshots, only: :create
  resources :variances, only: :index

end
