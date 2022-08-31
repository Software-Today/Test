Rails.application.routes.draw do
  root 'authentication#create'

  post 'register' => 'registration#create'
  post 'login' => 'authentication#create'
  delete 'users' => 'registration#destroy'

  resources :questions do
    resources :answers, shallow: true
  end
end
