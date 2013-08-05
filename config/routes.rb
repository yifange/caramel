Caramel::Application.routes.draw do
	root 'session_page#signin'

  get 'session_page/signin' => 'session_page#signin'
  get 'session_page/verify' => 'session_page#verify'
  get 'session_page/signout' => 'session_page#signout'

  get 'people_page/staff' => 'people_page#staff'
  get 'people_page/staff' => 'people_page#teachers'
  get 'people_page/staff' => 'people_page#students'

  get 'programs_page/regions' => 'programs_page#regions'
  get 'programs_page/instrument_types' => 'programs_page#instrument_types'
  get 'programs_page/program_types' => 'programs_page#program_types'
  get 'programs_page/schools' => 'programs_page#schools'
  get 'programs_page/programs' => 'programs_page#programs'

  # singlar API
  #         /photos   /photos/:id
  # Get     index     show
  # Post    create    
  # Put               update
  # Delete  remove    destroy

  # instruments
  resources :instruments, only: [:index, :show, :create, :update, :destroy] do
    collection do
      delete 'remove'
    end
  end
  delete '/instruments', to: redirect('/instruments/remove')

  # students
  resources :students, only: [:index, :show, :create, :update, :destroy] do
    collection do
      delete 'remove'
    end
  end
  delete '/students', to: redirect('/students/remove')

  # staff
  resources :staff, only: [:index, :show, :create, :update, :destroy] do
    collection do
      delete 'remove'
    end
  end
  delete '/staffs', to: redirect('/staffs/remove')

  # teachers
  resources :teachers, only: [:index, :show, :create, :update, :destroy] do
    collection do
      delete 'remove'
    end
  end
  delete '/teachers', to: redirect('/teachers/remove')

  # regions
  resources :regions, only: [:index, :show, :create, :update, :destroy] do
    collection do
      delete 'remove'
    end
  end
  delete '/regions', to: redirect('/regions/remove')

  # programs
  resources :programs, only: [:index, :show, :create, :update, :destroy] do
    collection do
      delete 'remove'
    end
  end
  delete '/programs', to: redirect('/programs/remove')

  # teachers of a program
  resources :programs do
      resources :teachers, only: [:index, :update]
  end

  # programs of a teacher  
  resources :teachers do
      resources :programs, only: [:index]
  end

  # instruments of a program  
  resources :programs do
      resources :instruments, only: [:show, :update]
  end
end
