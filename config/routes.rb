Caramel::Application.routes.draw do
  get "students/regions"
  root 'session_page#signin'

  get 'session_page/signin' => 'session_page#signin'
  get 'session_page/verify' => 'session_page#verify'
  get 'session_page/signout' => 'session_page#signout'

  # instruments
  resources :instruments

  # students
  resources :students

  # staff
  resources :staffs

  # teachers
  resources :teachers

  # regions
  resources :regions

  # programs
  resources :programs

  # teachers of a program
  # instruments of a program  
  resources :programs do
    resources :teachers
    resources :instruments
  end

  # programs of a teacher  
  resources :teachers do
    resources :programs
  end

end
