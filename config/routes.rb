Rails.application.routes.draw do
  root 'service_providers#index'
  resources :service_providers, only: [:create, :show, :update] do
    resources :consumers, only: [:index, :create, :update, :show]
  end
  match '/:service_provider_id/oauth2/token', to: 'oauth2/token#create', as: 'oauth2_token', via: [:get, :post]
  get '/:service_provider_id/oauth2/authorize', to: 'oauth2/authorize_implicit#new', as: 'oauth2_authorize_implicit', constraints: ->(request) { request.params['response_type'] == 'token' }
  get '/:service_provider_id/oauth2/authorize', to: 'oauth2/authorize_code#new', as: 'oauth2_authorize_code', constraints: ->(request) { request.params['response_type'] == 'code' }
  post '/:service_provider_id/oauth2/authorize', to: 'oauth2/authorize_code#create', as: 'oauth2_authorize_redirect_with_code'
  get '/:service_provider_id/oauth2/authorize', to: 'oauth2#authorize', as: 'oauth2_authorize'
  post '/:service_provider_id/oauth2/unauthorized', to: 'oauth2#unauthorized', as: 'oauth2_unauthorized'
  post '/:service_provider_id/oauth2/revoke', to: 'oauth2#revoke', as: 'oauth2_revoke'
  post '/:service_provider_id/oauth2/introspect', to: 'oauth2#introspect', as: 'oauth2_introspect'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
