Rails.application.routes.draw do

#### HOME
  get '/' => 'home#index', as: 'home'

#### TAGS
  get '/:group_slug/tags' => 'tags#index', as: 'tags'
  get '/:group_slug/memes/tags/:tag' => 'tags#show', as: 'tag'

#### USERS
    # Login
    get '/login' => 'sessions#new', as: 'login'
    post '/login' => 'sessions#create', as: 'create_login'

    # Logout
    delete '/logout' => 'sessions#destroy', as: 'logout'

#### GROUPS

    get '/groups/new' => 'groups#new', as: 'new_group'
    get '/groups' => 'groups#index'
    get '/:group_slug' => 'groups#show', as: 'group'
    post '/:groups' => 'groups#create'
    get '/:group_slug/edit/users' => 'groups#edit_users', as: 'edit_users'
    get '/:group_slug/edit' => 'groups#edit', as: 'edit_group'
    get '/:group_slug/users' => 'groups#user_index', as: 'view_users'


#### MEMES
  #Create
  get '/:group_slug/memes/new' => 'memes#new' #IMPORTANT: If you change this route, you MUST update tag_autocomplete.js, which grabs the group_slug based on 'var group_slug = window.location.pathname.split('/')[1]'
  post '/:group_slug/memes' => 'memes#create', as: 'create_meme'

  #index
  get '/:group_slug/memes' => 'memes#index', as: 'memes'
  get '/:group_slug/memes/by/:sort' => 'memes#index', as: 'memes_sort'  #most popularity

  #Show
  get '/:group_slug/memes/:id' => 'memes#show', as: 'meme'
  post '/:group_slug/memes/:id/react' => 'memes#react', as: :react


  #Destroy
  delete '/:group_slug/memes/:id' => 'memes#destroy'

  #invites
  get '/:group_slug/invites/new' => 'invites#new', as: 'invite_new'
  post '/:group_slug/invites' => 'invites#create', as: 'invites'

  # Registration
  get '/users/new' => 'registrations#new', as: 'registration_new'
  post '/users/new' => 'registrations#create', as: 'registration_create'
  get '/users/existing' => 'registrations#add_group_to_existing', as: 'add_group_to_existing'
  post '/users/existing' => 'registrations#add_group_to_existing_create', as: 'add_group_to_existing_create'

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


#### COMMENTS
  post '/:group_slug/memes/:id/comment' => 'comments#create', as: :comment

end
