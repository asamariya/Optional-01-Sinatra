require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  # BetterErrors.application_root = File.expand_path('..', __FILE__)
  BetterErrors.application_root = File.expand_path(__dir__)
end

require_relative 'lib/cookbook.rb'
require_relative 'lib/recipe.rb'


get '/' do
  cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))
  recipe = Recipe.new(
    name: params[:name],
    description: params[:description],
    difficulty: params[:difficulty],
    prep_time: params[:prep_time]
  )
  cookbook.add_recipe(recipe)
  redirect to '/'
end

get '/recipes/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))
  cookbook.remove_recipe(params[:index].to_i)
  redirect to '/'
end
