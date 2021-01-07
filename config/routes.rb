Rails.application.routes.draw do
  root 'home#index'
  resources :competitions,only:[:index,:show,:create]
  namespace :api,format:'json' do

      resources :items,only:[:index,:update]
  end
end
