Pingpong::Application.routes.draw do
  devise_for :admins

  resources :teams
  root :to => "teams#index"

  resources :matches do
    member do
      put 'declare_win'
      put 'set_schedule'
    end

    collection do
      get 'all'
      get 'serious'
      get 'fun'
      get 'doubles'
    end
  end

  resources :matches

	get 'rules' => 'rules#index'

end
