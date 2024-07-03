defmodule MegaCache.Worker do
  require Logger
  use GenServer

  def start_link(db_folder) do
    GenServer.start_link(__MODULE__, db_folder)
  end

  @impl GenServer
  def init(db_folder) do
    # Ensure the filepath exists
    Logger.info("Starting Mega Cache Worker")
    {:ok, db_folder}
  end

  def write_data(pid, key, value) do
    GenServer.call(pid, {:save_data, key, value})
  end

  def read_data(pid, key) do
    GenServer.call(pid, {:get_data, key})
  end

  @impl GenServer
  def handle_call({:get_data, key}, _from, db_folder) do
    case File.read("#{db_folder}/#{key}") do
      {:ok, file_data} -> {:reply, {:ok, file_data}, db_folder}
      {:error, reason} -> {:reply, {:error, reason}, db_folder}
    end
  end

  def handle_call({:save_data, key, value}, _from, db_folder) do
    case File.write("#{db_folder}/#{key}", value) do
      :ok -> {:reply, {:ok, key}, db_folder}
      {:error, reason} -> {:reply, {:error, reason}, db_folder}
    end
  end
end
