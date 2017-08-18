require 'sinatra'
require 'json'
require 'redis'
require 'singleton'
require_relative 'game_selector'
require_relative 'name_selector'

class Butts
  include Singleton

  attr_reader :redis

  def initialize
    @redis = Redis.new url: ENV.fetch('REDIS_URL', nil)
  end
end

def redis
  Butts.instance.redis
end

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
  GameSelector.new(:unplayed, params[:site]).random.to_json
end

get '/api/batman' do
  GameSelector.new(:unplayed, :batman).random.to_json
end

get '/api/character-name' do
  NameSelector.new.random.to_json
end

get '/api/character-name/:sex' do
  NameSelector.new(params[:sex]).random.to_json
end

def selectable_heroes(key)
  hero_json = redis.get key
  heroes = JSON.parse(hero_json) if hero_json
  return heroes if heroes && heroes.any?
  %w(Sombra Widowmaker)
end

get '/api/overwatch/hero' do
  key = :overwatch_heroes
  heroes = selectable_heroes key
  hero = heroes.shuffle.first
  heroes.delete hero
  redis.set key, heroes.to_json if heroes.any?
  redis.del key if heroes.empty?
  {
    hero: hero,
  }.to_json
end

get '/api/:type' do
  return 404 unless GameSelector::TYPES.include? params[:type]
  GameSelector.new(params[:type]).random.to_json
end

get '/:type' do
  return 404 unless GameSelector::TYPES.include? params[:type]
  GameSelector.new(params[:type]).random.to_s
end
