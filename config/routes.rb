Rails.application.routes.draw do
  namespace :api do
    resources :users, except:[:new, :edit]
    resources :sessions, only:[:create, :destroy]
  end
end
