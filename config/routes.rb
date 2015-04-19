Rails.application.routes.draw do
  resources :responders,  constraints: { format: 'json' }
  resources :emergencies,  constraints: { format: 'json' }
end
