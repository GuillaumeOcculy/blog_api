Rails.application.routes.draw do
  api_version(:module => 'V1', :path => {:value => 'v1'}, :defaults => {:format => 'json'}, :default => true) do
    post :auth, to: 'authentication#create'

    resources :users, only: [:create]

    resources :posts, only: [:index, :show, :create] do
      scope module: :posts do
        resources :likes, only: [:index]
        resource :likes, only: [:create, :destroy]
      end
    end
  end
end
