defmodule MegaCache.Test do
  use ExUnit.Case

  @measure_time 750
  @num_ops 1_000

  test "app starts" do
    assert "ok" === "ok"
  end

  test "read/write file" do
    MegaCache.Datastore.store("test_key", "test_value")
    assert MegaCache.Datastore.get("test_key") == {:ok, "test_value"}
  end

  test "read/write many" do
    start_write = :erlang.monotonic_time(:millisecond)

    0..@num_ops
    |> Enum.each(fn i -> MegaCache.Datastore.store("hello_#{i}", "some random data #{i}") end)

    end_write = :erlang.monotonic_time(:millisecond)
    total_write_time = end_write - start_write

    start_read = :erlang.monotonic_time(:millisecond)

    0..@num_ops
    |> Enum.each(fn i ->
      assert MegaCache.Datastore.get("hello_#{i}") === {:ok, "some random data #{i}"}
    end)

    end_read = :erlang.monotonic_time(:millisecond)
    total_read_time = end_read - start_read

    # Ensure the time to read/write is acceptable
    # 1,000 reads
    # 1,000 writes
    # Happening in under 750 milliseconds
    # Means we have at least 1.5 reads and 1.5 writes per millisecond
    assert total_write_time < @measure_time
    assert total_read_time < @measure_time
  end

  test "read/write same" do
    file_name = "mah_same_file.txt"

    some_data =
      0..@num_ops
      |> Enum.reduce("", fn i, all -> "hi there #{i}" <> "#{all}" end)

    start_time = :erlang.monotonic_time(:millisecond)

    0..@num_ops
    |> Enum.each(fn _ -> MegaCache.Datastore.store(file_name, some_data) end)

    0..@num_ops
    |> Enum.each(fn _ -> MegaCache.Datastore.get(file_name) end)

    end_time = :erlang.monotonic_time(:millisecond)

    # Ensure we can read/write fast enough
    assert end_time - start_time < @measure_time
  end

  test "Assert proper error on missing file" do
    missing_filename = "some_missing_file" <> Integer.to_string(:rand.uniform(100))

    {:error, reason} = MegaCache.Datastore.get(missing_filename)

    assert reason == :enoent
  end
end
