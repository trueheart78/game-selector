require 'sinatra'
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

get '/:type' do
  return 404 unless Selector::TYPES.include? params[:type]
  Selector.new(params[:type]).random.to_s
end
