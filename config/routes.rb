RokCms::Engine.routes.draw do
  resources :sites, only: [] do
    resources :layouts, shallow: true
    resources :themes, shallow: true
    resources :pages, shallow: true
  end
end
