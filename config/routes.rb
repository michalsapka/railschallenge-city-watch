Rails.application.routes.draw do
  resources :responders, only: [:index, :create, :show, :update], constraints: { format: 'json' }
  resources :emergencies, only: [:index, :create, :show, :update], constraints: { format: 'json' }

  match '*all', to: 'application#action_not_found', via: [:get, :patch, :delete]
end
