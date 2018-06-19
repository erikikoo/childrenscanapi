Rails.application.routes.draw do
  #resources :sms_messages
  
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'users#login'
      get 'test', to: 'users#test'
      resources :sms_messages, only: [:index, :show, :create, :destroy]
      get 'sms_historico', to: 'sms_messages#app_historico'
      get 'notifica', to: 'sms_messages#notifica'
      resources :monitor_users
      resources :users
      resources :children
      resources :estatistica, only: [:index]
    end
  end 
  
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
