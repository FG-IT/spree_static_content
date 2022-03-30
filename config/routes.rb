Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    resources :pages do
      patch :translate, on: :member
    end
  end
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      get 'pages', to: 'pages#index', as: :pages
    end
  end

  constraints(Spree::StaticPage) do
    get '/(*path)', to: 'static_content#show', as: 'static'
  end
end
