Rails.application.routes.draw do
  get 'home', to: 'home#index'

  namespace :api,format:'json' do
      resources :competitions,only:[:index,:show,:create]
      resources :items,only:[:update]
  end
end
