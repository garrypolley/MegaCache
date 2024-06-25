defmodule MegaCache.Application do
  use Application

  @impl Application
  def start(_, _) do
    path = System.get_env("FILE_PATH", "database_test")
    :application.set_env(:mega_cache, :file_path, path)
    IO.puts("Starting Mega Cache Application")
    MegaCache.System.start_link()
  end
end
