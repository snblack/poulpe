Rails.application.routes.draw do
   resources :products do
    resources :keywords, shallow: true
  end
end
