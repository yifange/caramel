Caramel::Application.routes.draw do
  get 'subways' => 'subways#index'
  post 'subways/sub' => 'subways#sub'
	get 'people' => 'people#staff'
	get 'programs' => 'programs#regions'
	get 'classes' => 'classes#calendar'

  get "programs/get_teachers" => "programs#get_teachers"
  post "programs/save_teachers" => "programs#save_teachers"

  get "programs/get_instruments" => "programs#get_instruments"
  post "programs/save_instruments" => "programs#save_instruments"

  get "lunchpads" => "lunchpads#index"
  get "lunchpads/api" => "lunchpads#api"
  post "lunchpads/lunch" => "lunchpads#lunch"
	get ':controller/:action/'

	root 'session#signin'
end
