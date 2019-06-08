class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #index
  get '/recipes' do
    @recipes = Recipe.all
    erb :index #set up a controller action that will render a form to create a new recipe
  end

#new/create
  get '/recipes/new' do
    #create a controller action that uses RESTful routes to display a single recipe.
    erb :new
  end

  post '/recipes' do
    #controller action that uses RESTful routes and renders a form to edit a single recipe.
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    #This controller action should update the entry in the database with the changes, and
    #then redirect to the recipe show page
    redirect "/recipes/#{@recipe.id}"
  end

  #show
  get '/recipes/:id' do
    #controller action (index action) that displays all the recipes in the database
    @recipe = Recipe.find_by_id(params[:id])
    erb :show

  end

  #edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    #Add to the recipe show page a form that allows a user to delete a recipe.
    #This form should submit to a controller action that deletes the entry from the
    #database and redirects to the index page.
    @recipe= Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect '/recipes'
  end
end
