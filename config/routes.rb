Caramel::Application.routes.draw do
  get "programs_page/get_teachers" => "programs_page#get_teachers"
  post "programs_page/save_teachers" => "programs_page#save_teachers"

  # get "programs_page/get_students" => "programs_page#get_students"
  post "programs_page/save_students" => "programs_page#save_students"

  get "programs_page/get_instruments" => "programs_page#get_instruments"
  post "programs_page/save_instrument" => "programs_page#save_instrument"

  get "programs_page/get_course_types" => "programs_page#get_course_types"
  post "programs_page/save_course_type" => "programs_page#save_course_type"

  post "programs_page/save_regular_courses" => "programs_page#save_regular_courses"
  post "programs_page/save_group_courses" => "programs_page#save_group_courses"
  
  get "people_page/get_regions" => "people_page#get_regions"

	root 'session_page#signin'
	get ':controller/:action/'

  resources :instruments, :programs
end
