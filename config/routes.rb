Rails.application.routes.draw do
  # Homepage
  root                                  'landing_pages#home'

  # Landing Pages Controller
  get     'help'                  =>    'landing_pages#help'
  get     'contact'               =>    'landing_pages#contact'
  get     'dashboard'             =>    'landing_pages#dashboard'

  # Student Controller
  get     'student_registration'  =>    'students#new'
  get     'history'               =>    'payments#index' # For Payment History

  # Staff Controller
  get     'staff_registration'    =>    'staffs#new'

  # Session Controller
  get     'login'                 =>    'sessions#new'
  post    'login'                 =>    'sessions#create'
  get     'tfa'                   =>    'sessions#tfa'
  post    'tfa'                   =>    'sessions#tfa'
  delete  'logout'                =>    'sessions#destroy'

  # Programme Controller
  get     'programme_registration'  =>    'programmes#new'

  # Utility Fees Controller
  get     'utility_fee_registration' =>    'utility_fees#new'
  get     'utility_fees'             =>    'utility_fees#index'

  get     'password_resets/edit'

  # Statistic controller
  get     'statistics'              =>      'statistics#index'
  get     'student_stats'           =>      'statistics#student'
  post    'student_stats'           =>      'statistics#student'
  get     'payment_stats'           =>      'statistics#payment'
  post    'payment_stats'           =>      'statistics#payment'

  # Report controller
  get     'reports'                 =>      'reports#index'
  get     'monthly_report'          =>      'reports#monthly'
  post    'monthly_report'          =>      'reports#monthly'
  get     'annual_report'           =>      'reports#annual'
  post    'annual_report'           =>      'reports#annual'

  # Mapping for pay function to the new in payments controller
  # map.resources :payments, :new => { :pay => :get }

  # Resources
  resources :programmes do
    resources :intakes
  end

  resources :students do
    resources :student_fees do
      resources :payments do
        collection do
          post 'pay'
        end
      end
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
  resources :locations

end
