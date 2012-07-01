GitReviewer::Application.routes.draw do
  resources :commits

  resources :repositories do
    get :sync
    resources :commits do
      put :claim, :close
    end
  end

  resources :licenses

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root :to => "home#index"
end
