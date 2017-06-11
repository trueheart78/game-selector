require 'sinatra'
require_relative 'selector'

get '/' do
  Selector.new(:unplayed).random.to_s
end

get '/types' do
  Selector::TYPES.join ', '
end

get '/:type' do
  return 404 unless Selector::TYPES.include? params[:type]
  Selector.new(params[:type]).random.to_s
end
