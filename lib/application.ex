defmodule MegaCache.Application do
  use Application

  @impl Application
  def start(_, _) do
    IO.puts("Starting Mega Cache Application")
    MegaCache.System.start_link()
  end
end
