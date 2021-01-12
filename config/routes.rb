Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :competitions,only:[:index,:show]
  namespace :api,format:'json' do
      resources :items,only:[:index,:update]
  end
end
