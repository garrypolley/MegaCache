defmodule MegaCache.Application do
  require Logger
  use Application

  @impl Application
  def start(_, _) do
    Logger.info("Starting Mega Cache Application")
    MegaCache.System.start_link()
  end
end
