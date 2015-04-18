Rails.application.routes.draw do
  resources :responders,  constraints: { format: 'json' }
end
