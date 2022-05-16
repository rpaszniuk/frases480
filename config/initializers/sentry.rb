Sentry.init do |config|
  config.dsn = 'https://ced6ad15e65f4acbbba2019335427c26:199092697f3844afbed69da14b4d195a@sentry.io/1763711'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.enabled_environments = %w[production]
  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
