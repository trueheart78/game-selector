require 'singleton'
require 'redis'
require 'redis-namespace'

class RedisAdapter
  include Singleton

  def initialize
    @redis = nil
  end

  def redis
    @redis ||= Redis::Namespace.new namespace, redis: connection
  end

  private

  def namespace
    "game_selector:#{ENV['RACK_ENV']}"
  end

  def connection
    Redis.new url: url
  end

  def url
    ENV.fetch 'REDIS_URL', nil
  end
end

def redis
  RedisAdapter.instance.redis
end
