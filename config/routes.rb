Rails.application.routes.draw do

  devise_for :admins

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user

  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get 'profiles/show'

  get 'browse', to: 'posts#browse', as: :browse_posts

  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get ':user_name', to: 'profiles#show', as: :profile

  root 'posts#index'

  # New route underneath
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile

  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

end
