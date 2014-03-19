Rails.application.routes.draw do
  root to: 'landing#index'

  resources :emoticons, only: [:index] do
    collection do
      get 'export'
    end
  end
end
