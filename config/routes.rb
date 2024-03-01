Rails.application.routes.draw do
   root "customers#index"
  # resources :customers
      get "send_email", to: "send#send_email" #as: 'sending_email'
  
  resources :customers do
    member do
      get 'download_pdf'
      get 'profile_update', to: "customers#profile_update"
    end
  end
  
  resources :customers do
    collection { post :import }
  end
 
end
