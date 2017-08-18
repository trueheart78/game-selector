shared_context 'redis cleanup' do
  after { redis_flush_namespace }

  # Redis.flushdb, but at the namespace level
  def redis_flush_namespace
    keys = redis.keys
    return if keys.empty?
    redis.del keys
  end

  # Redis.dbsize, but at the namespace level
  def redis_namespace_size
    redis.keys.size
  end
end
