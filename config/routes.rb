Caramel::Application.routes.draw do
	get 'people' => 'people#staff'
	get 'programs' => 'programs#regions'
	get 'classes' => 'classes#calendar'

	get ':controller/:action/'

	root 'signin#index'
end
