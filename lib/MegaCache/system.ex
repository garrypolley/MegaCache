defmodule MegaCache.System do
  require Logger

  def start_link do
    Logger.info("Starting Mega Cache System")

    Supervisor.start_link(
      [
        MegaCache.Datastore,
        MegaCache.Api
      ],
      strategy: :one_for_one
    )
  end
end
