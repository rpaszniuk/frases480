class CacheEngine
  include CacheEngine::Global

  def self.get(key)
    data = REDIS.get(key)
    Rails.logger.info("[CACHE] GET #{key} -> #{data.nil? ? 'missed' : 'ok'}")
    return nil unless data

    begin
      Marshal.load(data)
    rescue StandardError
      data
    end
  end

  def self.set(key, value, expires_in = nil)
    if expires_in
      REDIS.setex(key, expires_in, Marshal.dump(value))
    else
      REDIS.set(key, Marshal.dump(value))
    end
  end

  def self.del(key)
    REDIS.del(key)
  end

  def self.wildcard_del(wildcard)
    keys = REDIS.keys(wildcard)
    keys.each do |key|
      REDIS.del(key)
    end
  end
end
