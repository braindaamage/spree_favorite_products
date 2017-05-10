Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :favorite_products, :only => :index do
      get :users, :on => :member
      get :export, :on => :collection
    end
  end

  resources :favorite_products, :only => [:index, :create, :destroy]
end
