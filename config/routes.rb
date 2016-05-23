Rails.application.routes.draw do

  #resources :memes, only: [:index]

  # resources :groups, only: [:index, :show], params: :slug do
  #   resources :memes, only: [:index, :show]
  # end


#### HOME
  get '/' => 'home#index', as: 'home'


#### USERS
    # Login
    get '/login' => 'sessions#new', as: 'login'
    post '/login' => 'sessions#create', as: 'create_login'

    # Logout
    delete '/logout' => 'sessions#destroy', as: 'logout'



#### GROUPS
    get '/groups/new' => 'groups#new'
    get '/groups' => 'groups#index'
    get '/:group_slug' => 'groups#show', as: 'group'
    post '/:groups' => 'groups#create'
    get '/:group_slug/admin' => 'groups#admin', as: 'admin'

#### MEMES
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

#### COMMENTS

  post '/:group_slug/memes/:id/comment' => 'comments#create', as: :comment

end
