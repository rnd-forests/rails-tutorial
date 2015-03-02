Rails.application.routes.draw do

    root                'static_pages#home'
    get 'help'       => 'static_pages#help'
    get 'about'      => 'static_pages#about'
    get 'contact'    => 'static_pages#contact'
    get 'signup'     => 'users#new'

    get 'signin'     => 'sessions#new'
    post 'signin'    => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
    get 'search'     => 'articles#search'

    resources :users do
        member do
            get :following, :followers, :articles, :activities
        end
    end

    resources :articles do
        member do
            resources :comments, only: [:create, :destroy]
        end
    end

    resources :tags, only: [:index, :show]
    resources :relationships, only: [:create, :destroy]
    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]
end
