import Config

# Using a different http port in test to allow running tests while the iex shell session is running.
http_port =
  if config_env() != :test,
    do: System.get_env("MEGA_CACHE_HTTP_PORT", "5858"),
    else: System.get_env("MEGA_CACHE_HTTP_PORT", "5857")

config :mega_cache, http_port: String.to_integer(http_port)

# Pass in filepath so the mounted file system is properly used
file_path =
  if config_env() != :test,
    do: System.get_env("MEGA_CACHE_FILE_PATH", "./database"),
    else: System.get_env("MEGA_CACHE_FILE_PATH", "./database_test")

config :mega_cache, file_path: file_path
