Rails.application.routes.draw do
  namespace :api do
    post "login" => "sessions#create"
    post "register" => "users#create"
    resources :shortens, only: [:show, :create]
  end
  get '/:short_url', to: 'api/shortens#show', as: :shortened
end
