defmodule MegaCache.Worker do
  require Logger
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(state) do
    # Ensure the filepath exists
    Logger.info("Starting Mega Cache Worker")
    :ok = File.mkdir_p(get_file_path())
    {:ok, state}
  end

  def write_data(key, value) do
    GenServer.cast(__MODULE__, {:save_data, key, value})
  end

  @impl GenServer
  def handle_cast({:save_data, key, value}, state) do
    save_data(key, value)
    {:noreply, state}
  end

  defp save_data(key, value) do
    File.write!("#{get_file_path()}/#{key}", value)
  end

  defp get_file_path do
    Application.get_env(:mega_cache, :file_path)
  end
end
