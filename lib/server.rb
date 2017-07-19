require 'sinatra'
require 'json'
require_relative 'selector'

get '/' do
  Selector.new(:unplayed, params[:site]).random.to_s
end

get '/batman' do
  Selector.new(:unplayed, :batman).random.to_s
end

get '/types' do
  Selector::TYPES.join ', '
end

before '/api*' do
  content_type 'application/json'
  response['Access-Control-Allow-Origin'] = '*'
end

get '/api' do
  {
    game: Selector.new(:unplayed, params[:site]).random.to_s
  }.to_json
end

get '/api/batman' do
  {
    game: Selector.new(:unplayed, :batman).random.to_s
  }.to_json
end

get '/api/character-name' do
  {
    name: 'Ashelia (F) - Final Fantasy XII'
  }.to_json
end

get '/api/:type' do
  return 404 unless Selector::TYPES.include? params[:type]
  {
    game: Selector.new(params[:type]).random.to_s
  }.to_json
end

get '/:type' do
  return 404 unless Selector::TYPES.include? params[:type]
  Selector.new(params[:type]).random.to_s
end
