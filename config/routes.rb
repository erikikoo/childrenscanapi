Rails.application.routes.draw do
  #resources :sms_messages
  
  namespace :api do
    namespace :v1 do
      post 'app/auth/login', to: 'users#appLogin'
      post 'auth/login', to: 'users#adminLogin'
      get 'test', to: 'users#test'
      get 'sms_historico', to: 'sms_messages#app_historico' 
      get 'sms_search', to: 'sms_messages#sms_search'
      put 'change_password', to: 'monitor_users#update'     
      resources :sms_messages, only: [:index, :show, :create, :destroy]
      resources :monitor_users
      resources :users
      resources :children
      resources :estatistica, only: [:index]
    end
  end 
  
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
