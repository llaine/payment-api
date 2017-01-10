Rails.application.routes.draw do

  resources :contracts, defaults: {format: :json} do
    resources :payments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
