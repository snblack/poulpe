Rails.application.routes.draw do
   resources :keywords, only: [:index]
end
