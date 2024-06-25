```
{:ok, pid} = Supervisor.start_link(MegaCache.Supervisor, strategy: :one_for_one)
MegaCache.Worker.write_data("garry", "data")
```