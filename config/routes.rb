Rails.application.routes.draw do
  
  
  
  
  
  namespace :api do
    namespace :v1 do      
      
      post 'app/auth/login', to: 'users#appLogin'
      post 'auth/login', to: 'users#adminLogin'
      
      put 'change_password', to: 'monitor_users#update'     
      
      get 'children/qr-code/:id', to: 'children#generate_qr_code'
      get 'children/app-responsavel/:uid', to: 'children#getChildrenPerUidDevice' 
      put 'children/status/:id', to: 'children#update_status'
      
      put 'users/status/:id', to: 'users#update_status'      
      
      get 'tickets/total', to: 'tickets#total'
      
      get 'notification-relatorio', to: 'notifications#index'

      get 'send_evento_for_all_devices/:id', to: "notifications#send_evento_for_all_devices"
      get 'monitor_count', to: 'monitor_users#countMonitor';
      get 'last_contato', to: 'contatos#show'
      post 'event_count', to: 'events#getEventCount'
      post 'event_read', to: 'events#eventRead'
      
      resources :prices
      resources :contatos
      resources :events
      resources :notifications
      resources :messages
      resources :tickets
      resources :answers      
      resources :monitor_users
      resources :users
      resources :children
      resources :estatistica, only: [:index]
      
    end
  end 
  
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
