class CacheEngine
  include CacheEngine::Global

  def self.get(key)
    data = Redis.current.get(key)
    # Rails.logger.info("[CACHE] GET #{key} -> #{data.nil? ? 'missed' : 'ok'}")
    return nil unless data

    begin
      Marshal.load(data)
    rescue StandardError
      data
    end
  end

  def self.set(key, value, expires_in = nil)
    if expires_in
      Redis.current.setex(key, expires_in, Marshal.dump(value))
    else
      Redis.current.set(key, Marshal.dump(value))
    end
  end

  def self.del(key)
    Redis.current.del(key)
  end
end
