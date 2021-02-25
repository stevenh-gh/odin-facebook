Rails.application.routes.draw do
  devise_for(:users, controllers: { registrations: 'registrations' })
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources(:users) do
    resources(:posts)
    resources(:comments)
  end
  resources(:friendships, only: %i[create destroy])

  root('users#index')
  get('rails/info/routes' => 'routes')
end
