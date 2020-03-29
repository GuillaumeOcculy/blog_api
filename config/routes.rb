Rails.application.routes.draw do
  api_version(:module => 'V1', :path => {:value => 'v1'}, :defaults => {:format => 'json'}, :default => true) do
    resources :users, only: [:create]
    resources :posts, only: [:index, :show, :create]
    post :auth, to: 'authentication#create'
  end
end
