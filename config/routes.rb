Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#index'
  get 'dashboard', to: 'dashboard#index' 

  resources :proponents do
    collection do
      post 'calculate_missing_inss'
    end
  end
end
