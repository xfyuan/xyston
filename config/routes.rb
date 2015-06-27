Rails.application.routes.draw do
  namespace :api do
    resources :users, except:[:new, :edit] do
      resources :products, only:[:create, :update, :destroy]
      resources :orders, only:[:index, :show, :create]
    end
    resources :sessions, only:[:create, :destroy]
    resources :products, only:[:index, :show]
  end
end
