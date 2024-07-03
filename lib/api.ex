defmodule MegaCache.Api do
  require Logger
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  def child_spec(_) do
    port = Application.fetch_env!(:mega_cache, :http_port)
    Logger.info("Starting Mega Cache API on port: #{port}")

    Plug.Cowboy.child_spec(
      scheme: :http,
      options: [port: String.to_integer(port)],
      plug: __MODULE__
    )
  end

  get "envvars" do
    env_data = Application.get_all_env(:mega_cache)
    |> IO.inspect()
    |> Enum.reduce("", fn (thing, all) ->
        {key, value} = thing
        "#{key}:#{value}\n" <> all
      end)

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "#{env_data}")
  end

  get "data/:key" do
    key = conn.path_params["key"]

    case MegaCache.Datastore.get(key) do
      {:ok, data} -> conn |> Plug.Conn.send_resp(200, data)
      {:error, _} -> conn |> Plug.Conn.send_resp(404, "File not found")
    end
  end

  post "data/:key" do
    {:ok, data, conn} =
      conn
      |> Plug.Conn.read_body(length: 10_000_000)

    key = conn.path_params["key"]

    case MegaCache.Datastore.store(key, data) do
      {:ok, key} -> conn |> Plug.Conn.send_resp(201, key)
      {:error, reason} -> conn |> Plug.Conn.send_resp(500, reason)
    end
  end

  match _ do
    Plug.Conn.send_resp(conn, 404, "not found default")
  end
end
