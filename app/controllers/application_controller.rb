class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #index
  get '/recipes' do
    @recipes = Recipe.all 
    erb :index 
  end 
  
  #new/create
  get '/recipes/new' do 
    erb :new
  end
  
  post '/recipes' do 
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end
  
  #show
  get '/recipes/:id' do
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
    # @recipe.name = params[:name]
    # @recipe.ingredients = params[:ingredients]
    # @recipe.cook_time = params[:cook_time]
    # @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end
  
  #delete 

  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])    
    @recipe.delete 
    redirect "/recipes"
  end
  
end
