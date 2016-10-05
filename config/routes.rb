Rails.application.routes.draw do
  
  get 'api' => 'api#index'

  post 'signup' => 'signup#post'

  post 'auth' => 'auth#post'

end