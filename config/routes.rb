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
      get 'event_count/:uid', to: 'events#getEventCount'
      get 'events/:id/:uid', to: 'events#show'
      post 'event_read', to: 'events#eventRead'
      get 'app_transporte-events/:monitor_id', to: 'events#app_transporte_show_events'
      get 'app_responsavel-events', to: 'events#app_responsavel_show_events'
      post 'devices', to: 'devices#create'
      get 'devices/:uid', to: 'devices#show'  
      
      delete 'mensalidades/:child_id/:mes', to: "mensalidades#destroy"
      get 'mensalidades/:child_id', to: "mensalidades#app_get_mensalidades"
      post 'mensalidades/:target', to: "mensalidades#create"
      
      get 'escolas/:user_id', to: "escolas#app_get_escolas"

      get 'send_alert_for_all_devices', to: 'alerts#send_alert'
      get 'app_get_alerts', to: 'alerts#app_get_alerts'
      get 'app_get_escolas', to: 'escolas#app_get_escolas'

      get 'app_get_alerta/:alert_id', to: 'alerts#app_get_alert'
      get 'app_get_alertas_per_device/:uid_device', to: 'alerts#app_get_alerts_sending'
      get 'send_code', to: 'children#send_code'
      resources :alerts
      resources :mensalidades
      resources :escolas
      resources :event_children
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
