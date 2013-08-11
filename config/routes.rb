Caramel::Application.routes.draw do
  root 'session_page#signin'

  get 'session_page/signin' => 'session_page#signin'
  get 'session_page/verify' => 'session_page#verify'
  get 'session_page/signout' => 'session_page#signout'

  resources :staffs, :teachers, :regions, :programs, :instruments, :students, :program_types, :schools

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
