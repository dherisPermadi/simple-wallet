Rails.application.routes.draw do
  devise_for :users, path: 'api/v1/users', defaults: { format: :json },
  controllers: {
    registrations: 'api/v1/registrations',
  }

  use_doorkeeper do
    skip_controllers :authorizations, :applications,
                     :authorized_applications
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, controllers: { registrations: 'api/v1/registrations' }
      resources :wallet_deposits, only: %i[create]
      resources :wallet_transactions, only: %i[create]

      get '/wallet/total_balance', to: 'wallets#total_balance', as: 'total_balance'
      get '/transaction_detail/top_transactions', to: 'transaction_details#top_transactions', as: 'top_transactions'
      get '/transaction_detail/top_users', to: 'transaction_details#top_users', as: 'top_users'
    end
  end
end
