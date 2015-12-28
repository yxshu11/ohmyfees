Rails.application.routes.draw do

  get 'staffs/new'

  get 'staffs/show'

  get 'staffs/index'

  root                      'landing_pages#home'

  # Landing Pages Controller
  get     'help'          =>    'landing_pages#help'
  get     'contact'       =>    'landing_pages#contact'
  get     'dashboard'     =>    'landing_pages#dashboard'

  # Student Controller
  get     'students'      =>    'students#index'
  get     'registration'  =>    'students#new'

  # Session Controller
  get     'login'         =>    'sessions#new'
  post    'login'         =>    'sessions#create'
  delete  'logout'        =>    'sessions#destroy'

  # Resources
  resources :students

end
