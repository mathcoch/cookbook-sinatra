require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'recipe'
require_relative 'cookbook'
require_relative 'service_navigator'

csv_file  = File.join(__dir__, 'recipes.csv')
cookbook  = Cookbook.new(csv_file)
navigator = ServiceNavigator.new


set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @message = "What's up?"
  erb :index
end

get '/add' do
  erb :add
end

get '/posts' do
  @name = params['name']
  @description = params['description']
  @cooking_time = params['cooking_time']
  @difficulty = params['difficulty']
  @is_done = "false"
  recipe = Recipe.new(@name, @description, @cooking_time, @difficulty, @is_done)
  cookbook.add_recipe(recipe)
  @message = 'Recipe added!'
  erb :index
end

get '/list' do
  @recipes = cookbook.all
  erb :list
end

get '/mark/:index' do
  cookbook.recipes[params['index'].to_i].change_status
  @recipes = cookbook.all
  erb :list
end

get '/delete/:index' do
  cookbook.remove_recipe(params['index'].to_i)
  redirect '/list'
end

get '/search' do
  @keyword = params['keyword']
  @recipes = navigator.search(@keyword)
  erb :list_import
end

get '/import/:keyword/:index' do
  # binding.pry
  recipes = navigator.search(params['keyword'])
  cookbook.add_recipe(recipes[params['index'].to_i])
  redirect '/list'
end
