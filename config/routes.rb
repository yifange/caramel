Caramel::Application.routes.draw do
	get 'people_page' => 'people_page#staff'
	get 'programs_page' => 'programs_page#regions'
	get 'classes_page' => 'classes_page#calendar'

  get "programs/get_teachers" => "programs#get_teachers"
  post "programs/save_teachers" => "programs#save_teachers"

  get "programs/get_instruments" => "programs#get_instruments"
  post "programs/save_instruments" => "programs#save_instruments"

  get "lunchpads" => "lunchpads#index"
  get "lunchpads/api" => "lunchpads#api"
  post "lunchpads/lunch" => "lunchpads#lunch"

	get ':controller/:action/'

	root 'session_page#signin'
end
