Rails.application.routes.draw do

  root                      'landing_pages#home'
  get 'help'          =>    'landing_pages#help'
  get 'contact'       =>    'landing_pages#contact'
  get 'dashboard'     =>    'landing_pages#dashboard'
  get 'students'      =>    'students#index'
  get 'registration'  =>    'students#new'

  resources :students
end
