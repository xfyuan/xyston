Rails.application.routes.draw do
  namespace :api do
    resources :users, except:[:new, :edit] do
      resources :products, only:[:create]
    end
    resources :sessions, only:[:create, :destroy]
    resources :products, only:[:index, :show]
  end
end
