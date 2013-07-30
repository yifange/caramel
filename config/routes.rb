Caramel::Application.routes.draw do
	get 'people' => 'people#staff'
	get 'programs' => 'programs#regions'
	get 'classes' => 'classes#calendar'

  get "programs/get_teachers" => "programs#get_teachers"
  post "programs/save_teachers" => "programs#save_teachers"

	get ':controller/:action/'

	root 'session#signin'
end
