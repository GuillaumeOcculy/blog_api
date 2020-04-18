Rails.application.routes.draw do
  api_version(:module => 'V1', :path => {:value => 'v1'}, :defaults => {:format => 'json'}, :default => true) do
    post :auth, to: 'authentication#create'

    get :profile, to: 'profile#show'

    resources :friends, only: [] do
      patch :accept
      patch :decline
    end

    resources :users, only: [:show, :create] do
      scope module: :users do
        resources :friends, only: [:index, :create]
      end
    end

    resources :posts, only: [:index, :show, :create] do
      scope module: :posts do
        resources :likes, only: [:index]
        resource :likes, only: [:create, :destroy]

        resources :comments, only: [:index, :create, :destroy]
      end
    end
  end
end
