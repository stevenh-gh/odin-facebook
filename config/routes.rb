Rails.application.routes.draw do
  devise_for(:users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' })
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources(:users) do
    resources(:posts) do
      resources(:likes)
    end
    resources(:comments)
    resources(:profiles)
  end
  resources(:friendships, only: %i[index create destroy])
  resources(:friend_requests)

  root('users#index')
  get('rails/info/routes' => 'routes')
end
