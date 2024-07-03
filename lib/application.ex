defmodule MegaCache.Application do
  require Logger
  use Application

  @impl Application
  def start(_, _) do
    path = System.get_env("MEGA_CACHE_FILE_PATH", "database_test")
    http_port = System.get_env("MEGA_CACHE_HTTP_PORT", "5857")
    :application.set_env(:mega_cache, :http_port, http_port)
    :application.set_env(:mega_cache, :file_path, path)
    Logger.info("Starting Mega Cache Application")
    MegaCache.System.start_link()
  end
end
