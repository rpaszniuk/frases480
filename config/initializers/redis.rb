REDIS = Redis.new(
  host: Newfrases480::Application.credentials.redis[:host],
  port: Newfrases480::Application.credentials.redis[:port],
  connect_timeout: 10,
  timeout: 10,
  driver: :hiredis,
  thread_safe: true,
  reconnect_attempts: 5,
  reconnect_delay: 1.5,
  reconnect_delay_max: 5.0
)
