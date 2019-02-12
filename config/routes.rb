Rails.application.routes.draw do
  # See how all your routes lay out with "rake routes".
  scope module: 'api' do
    # Version API, we can make api updates without breaking old clients
    namespace :v1 do
      resources :articles, only: [:show, :create]
      get 'articles/(:id)', to: 'articles#show'
      get 'tags/:tag_name/:date', to: 'articles#index'
      post 'articles', to: 'articles#create'
    end
  end
end
