module CacheEngine::Global
  def cms_active_users_count
    cache_key = 'cms_active_users_count'
    cache_data = CacheEngine.get(cache_key)
    if cache_data.nil?
      cache_data = User.active.count
      CacheEngine.set(cache_key, cache_data, 30.minutes)
    end
    cache_data.to_i
  end

  def cms_total_count(collection_class)
    table = collection_class.to_s.underscore.pluralize
    cache_key = "cms_total_#{table}_count"
    cache_data = CacheEngine.get(cache_key)
    if cache_data.nil?
      cache_data = collection_class.all.count
      CacheEngine.set(cache_key, cache_data, 30.minutes)
    end
    cache_data.to_i
  end

  def web_categories
    cache_key = 'web_categories'
    cache_data = CacheEngine.get(cache_key)
    if cache_data.nil?
      cache_data = Category.active.order(:slug).to_a
      CacheEngine.set(cache_key, cache_data, 12.hours)
    end
    cache_data
  end

  def web_last_phrases
    cache_key = 'web_last_phrases'
    cache_data = CacheEngine.get(cache_key)
    if cache_data.nil?
      cache_data = Phrase.active.order(id: :desc).includes(:category).limit(15).to_a
      CacheEngine.set(cache_key, cache_data, 12.hours)
    end
    cache_data
  end
end
