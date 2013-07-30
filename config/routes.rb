Caramel::Application.routes.draw do
	get 'people' => 'people#staff'
	get 'programs' => 'programs#regions'
	get 'classes' => 'classes#calendar'

  get "programs/get_teachers" => "programs#get_teachers"
  post "programs/save_teachers" => "programs#save_teachers"

  get "programs/get_instruments" => "programs#get_instruments"
  post "programs/save_instruments" => "programs#save_instruments"

	get ':controller/:action/'

	root 'signin#index'
end
