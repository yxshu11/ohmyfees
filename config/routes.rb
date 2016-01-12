Rails.application.routes.draw do
  # Homepage
  root                                  'landing_pages#home'

  # Landing Pages Controller
  get     'help'                  =>    'landing_pages#help'
  get     'contact'               =>    'landing_pages#contact'
  get     'dashboard'             =>    'landing_pages#dashboard'

  # Student Controller
  get     'students'              =>    'students#index'
  get     'student_registration'  =>    'students#new'

  get     'view_fees'             =>    'student_fees#index'
  get     'payment'               =>    'student_fees#payment'

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

  # Intake Controller
  get     'intakes'                 =>    'intakes#index'

  # Utility Fees Controller
  get     'utility_fee_registration' =>    'utility_fees#new'
  get     'utility_fees'             =>    'utility_fees#index'


  # Resources
  resources :programmes do
    resources :intakes
  end

  resources :utility_fees
  resources :intakes
  resources :students
  resources :staffs

end
