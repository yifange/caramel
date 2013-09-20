Caramel::Application.routes.draw do
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  get 'calendars/week' => 'calendars#index_week', :as => :calendars_week
  get "schedules/week" => "schedules#index_week", :as => :schedules_week
  get "rosters/add" => "rosters#add_student"
  delete "rosters/remove" => "rosters#remove_student"

  get 'lunchpads/api' => 'lunchpads#api'
  post 'lunchpads/lunch' => 'lunchpads#lunch'

  # destroy multi entries using checkboxes
  post 'programs/destroy_multi' => 'programs#destroy_multi'
  post 'teachers/destroy_multi' => 'teachers#destroy_multi'
  post 'staffs/destroy_multi' => 'staffs#destroy_multi'
  post 'students/destroy_multi' => 'students#destroy_multi'
  post 'regions/destroy_multi' => 'regions#destroy_multi'
  post 'instruments/destroy_multi' => 'instruments#destroy_multi'
  post 'program_types/destroy_multi' => 'program_types#destroy_multi'
  post 'schools/destroy_multi' => 'schools#destroy_multi'

  resources :events, :month_events, :calendars, :attendances, :navs, :lunchpads, :courses, :rosters, :password_resets, :schedules, :users, :staffs, :teachers, :regions, :programs, :instruments, :students, :profiles, :admins, :program_types, :schools, :reports
	root 'session_page#signin'

  get 'session_page/signin' => 'session_page#signin'
  post 'session_page/verify' => 'session_page#verify'
  get 'session_page/signout' => 'session_page#signout'

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

  # regions of a teacher  
  resources :teachers do
    resources :regions
  end

end
