defmodule MegaCache.System do
  def start_link do
    IO.puts("Starting Mega Cache System")
    Supervisor.start_link(
      [
        MegaCache.Worker
      ],
      strategy: :one_for_one
    )
  end
end
