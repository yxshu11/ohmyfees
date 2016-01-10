Rails.application.routes.draw do

  root                                  'landing_pages#home'

  # Landing Pages Controller
  get     'help'                  =>    'landing_pages#help'
  get     'contact'               =>    'landing_pages#contact'
  get     'dashboard'             =>    'landing_pages#dashboard'

  # Student Controller
  get     'students'              =>    'students#index'
  get     'student_registration'  =>    'students#new'


  # Staff Controller

  get     'staffs'                =>    'staffs#index'
  get     'staff_registration'    =>    'staffs#new'

  # Session Controller
  get     'login'                 =>    'sessions#new'
  post    'login'                 =>    'sessions#create'
  delete  'logout'                =>    'sessions#destroy'

  # Programme Controller
  get     'programme_registration'  =>    'programmes#new'
  get     'programmes'              =>    'programmes#index'

  # Resources
  resources :programmes
  resources :students
  resources :staffs

end
