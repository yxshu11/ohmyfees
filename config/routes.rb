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

  get     'student_fees'          =>    'student_fees#index'

  # get     'pay'                   =>    'payments#new'
  get     'history'               =>    'payments#index'


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

  get     'password_resets/edit'

  # Resources
  resources :programmes do
    resources :intakes
  end

  resources :students do
    resources :student_fees do
      resources :payments
      resources :fines
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :utility_fees
  resources :student_fees
  resources :payments
  resources :intakes
  resources :staffs

end
