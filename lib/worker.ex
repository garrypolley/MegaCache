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
    File.mkdir_p(get_file_path())
    {:ok, state}
  end

  def write_data(key, value) do
    GenServer.cast(__MODULE__, {:save_data, key, value})
  end

  def read_data(key) do
    GenServer.call(__MODULE__, {:get_data, key})
  end

  @impl GenServer
  def handle_call({:get_data, key}, _from, state) do
    case File.read("#{get_file_path()}/#{key}") do
      {:ok, file_data} -> {:reply, file_data, state}
      {:error, _} -> {:noreply, state}
    end
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
