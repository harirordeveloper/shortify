Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/signup', to: 'users#create'
      post '/signin', to: 'sessions#create'
      delete '/signout', to: 'sessions#destroy'
      resource :urls do
        get :index
      end
    end
  end
  get "/:id", to: "api/v1/urls#show", as: :short_link
end
