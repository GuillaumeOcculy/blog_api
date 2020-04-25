Rails.application.routes.draw do
  api_version(:module => 'V1', :path => {:value => 'v1'}, :defaults => {:format => 'json'}, :default => true) do
    post :auth, to: 'authentication#create'

    get :profile, to: 'profile#show'

    resources :searches, only: [:index]

    scope module: :conversations do
      resources :conversations, only: [] do
        resources :messages, only: [:index, :create]
      end
    end

    scope module: :users do
      resources :messages, only: [:create]
      resources :conversations, only: [:index, :show]
      resources :friends, only: [:destroy]
      resources :friend_requests, only: [] do
        patch :accept
        patch :decline
      end
    end

    resources :users, only: [:show, :create] do
      scope module: :users do
        resources :posts, only: [:index]
        resources :friends, only: [:index, :create]
        resources :friend_requests, only: [:index, :create]
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
