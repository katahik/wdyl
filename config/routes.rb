Rails.application.routes.draw do
  get 'home', to: 'home#index'

  namespace :api,format:'json' do
      resources :competitions,only:[:index]
  end
end
