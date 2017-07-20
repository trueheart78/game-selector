require 'sinatra'
require 'json'
require_relative 'game_selector'
require_relative 'name_selector'

get '/' do
  GameSelector.new(:unplayed, params[:site]).random.to_s
end

get '/batman' do
  GameSelector.new(:unplayed, :batman).random.to_s
end

get '/types' do
  GameSelector::TYPES.join ', '
end

before '/api*' do
  content_type 'application/json'
  response['Access-Control-Allow-Origin'] = '*'
end

get '/api' do
  {
    game: GameSelector.new(:unplayed, params[:site]).random.to_s
  }.to_json
end

get '/api/batman' do
  {
    game: GameSelector.new(:unplayed, :batman).random.to_s
  }.to_json
end

get '/api/character-name' do
  NameSelector.new.random.to_json
end

get '/api/character-name/:sex' do
  NameSelector.new(params[:sex]).random.to_json
end

get '/api/:type' do
  return 404 unless GameSelector::TYPES.include? params[:type]
  {
    game: GameSelector.new(params[:type]).random.to_s
  }.to_json
end

get '/:type' do
  return 404 unless GameSelector::TYPES.include? params[:type]
  GameSelector.new(params[:type]).random.to_s
end
