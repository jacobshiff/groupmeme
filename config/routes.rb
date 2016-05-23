Rails.application.routes.draw do

  #resources :memes, only: [:index]

  # resources :groups, only: [:index, :show], params: :slug do
  #   resources :memes, only: [:index, :show]
  # end


######## Home routes
  get '/' => 'home#index', as: 'home'


######## Users
    # Login
    get '/login' => 'sessions#new', as: 'login'
    post '/login' => 'sessions#create', as: 'create_login'

    # Logout
    delete '/logout' => 'sessions#destroy', as: 'logout'



#####Groups
    get '/groups/new' => 'groups#new'
    get '/groups' => 'groups#index'
    get '/:group_slug' => 'groups#show', as: 'group'
    post '/:groups' => 'groups#create'
    get '/:group_slug/edit/users' => 'groups#edit_users', as: 'edit_users'
    get '/:group_slug/edit' => 'groups#edit', as: 'edit_group'


######### Memes routes
  #Create
  get '/:group_slug/memes/new' => 'memes#new'
  post '/:group_slug/memes' => 'memes#create'

  #Show
  get '/:group_slug/memes' => 'memes#index', as: 'memes'
  get '/:group_slug/memes/:id' => 'memes#show', as: 'meme'
  post '/:group_slug/memes/:id/react' => 'memes#react', as: :react

  #Destroy
  delete '/:group_slug/memes/:id' => 'memes#destroy'

  # Registration
  get '/users/new' => 'registrations#new', as: 'registration_new'
  post '/users/new' => 'registrations#create', as: 'registration_create'

  # User path
  get '/users/:username' => 'users#show', as: 'user'
  get '/users/:username/edit' => 'users#edit', as: 'edit_user'
  patch '/users/:username' => 'users#update'
  delete '/users/:username' => 'users#destroy'

  #get '/users/:user_id' => 'users#show' ###Rachel says: we might want to use this as well?
  #user profile page
  #can rewrite with user_slug

  #get '/users/:user_id/edit' => 'users#edit'


#####Memberships
  get '/:group_slug/:username/membership' => 'memberships#show'
  delete '/:group_slug/:username/membership' => 'memberships#destroy', as: 'destroy_membership'
  get '/:group_slug/:username/membership/edit' => 'memberships#edit', as: 'edit_membership'
  patch '/:group_slug/:username/membership/edit' => 'memberships#update'
#####Invitations

end
