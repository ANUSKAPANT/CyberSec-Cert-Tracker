Rails.application.routes.draw do
  resources :csv_files
  resources :records, only: :index
  resources :vendors
  resources :students
  resources :companies do
    collection do
      get :match_companies
    end
  end
  resources :courses
  resources :student_courses
  resources :cert_vouchers
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users, except: %i[edit new]
  post 'create_user' => 'users#create', as: :create_user
  root "homes#index"
  match '*path', to: 'homes#index', via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end