Rottenpotatoes::Application.routes.draw do
	resources :movies
	get '/movies/find-by-director/:id/' => 'movies#find_by_director', as: 'find_by_director'
	
	root 'movies#index'
end
