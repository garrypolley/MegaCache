defmodule MegaCache.Datastore do
  require Logger

  def child_spec(_) do
    db_folder = Application.get_env(:mega_cache, :file_path)
    File.mkdir_p(db_folder)

    Logger.info("Starting up MegaCache Datastore")

    :poolboy.child_spec(
      __MODULE__,
      [
        name: {:local, __MODULE__},
        worker_module: MegaCache.Worker,
        size: 3
      ],
      [db_folder]
    )
  end

  def store(key, value) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid ->
        case MegaCache.Worker.write_data(worker_pid, key, value) do
          {:ok, key} -> {:ok, key}
          {:error, reason} -> {:error, reason}
        end
      end
    )
  end

  def get(key) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid ->
        case MegaCache.Worker.read_data(worker_pid, key) do
          {:ok, data} -> {:ok, data}
          {:error, reason} -> {:error, reason}
        end
      end
    )
  end
end
