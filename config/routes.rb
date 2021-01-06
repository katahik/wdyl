Rails.application.routes.draw do
  root 'home#index'

  namespace :api,format:'json' do
      resources :competitions,only:[:index,:show,:create]
      resources :items,only:[:index,:update]
  end
end
