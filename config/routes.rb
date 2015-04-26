Rails.application.routes.draw do
  resources :responders, except: [:new, :edit, :destroy], constraints: { format: 'json' }
  resources :emergencies, except: [:new, :edit, :destroy], constraints: { format: 'json' }

  match '*all', to: 'application#action_not_found', via: [:get, :patch, :delete]
end
