Caramel::Application.routes.draw do
  get "programs_page/get_teachers" => "programs_page#get_teachers"
  post "programs_page/save_teachers" => "programs_page#save_teachers"

  get "programs_page/get_instruments" => "programs_page#get_instruments"
  post "programs_page/save_instruments" => "programs_page#save_instruments"

	root 'session_page#signin'
	get ':controller/:action/'

  resources :instruments
end
