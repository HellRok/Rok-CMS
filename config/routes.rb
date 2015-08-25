RokCms::Engine.routes.draw do
  resources :sites, only: [] do
    resources :layouts, shallow: true
  end
end
