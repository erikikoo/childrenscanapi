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
      get 'children/qr-code/:id', to: 'children#generate_qr_code'
      put 'children/status/:id', to: 'children#update_status'
      put 'users/status/:id', to: 'users#update_status'      
      get 'tickets/total', to: 'tickets#total'
      # get 'sms_per_month_and_user', to: 'sms_messages#get_sms_per_month_and_user'
      # get 'sms_all_per_user', to: 'sms_messages#get_all_sms_per_user'
      resources :messages
      resources :tickets
      resources :answers
      resources :sms_messages, only: [:index, :show, :create, :destroy]
      resources :monitor_users
      resources :users
      resources :children
      resources :estatistica, only: [:index]
    end
  end 
  
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
