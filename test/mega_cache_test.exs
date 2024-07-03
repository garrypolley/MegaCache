defmodule MegaCache.Test do
  use ExUnit.Case

  test "app starts" do
    assert "ok" === "ok"
  end

  test "read/write file" do
    MegaCache.Worker.write_data("test_key", "test_value")
    assert MegaCache.Worker.read_data("test_key") == "test_value"
  end

  test "read/write many" do
    start_write = :erlang.monotonic_time(:millisecond)

    0..1_000
    |> Enum.each(fn i -> MegaCache.Worker.write_data("hello_#{i}", "some random data #{i}") end)

    end_write = :erlang.monotonic_time(:millisecond)
    total_write_time = end_write - start_write

    start_read = :erlang.monotonic_time(:millisecond)

    0..1_000
    |> Enum.each(fn i ->
      assert MegaCache.Worker.read_data("hello_#{i}") === "some random data #{i}"
    end)

    end_read = :erlang.monotonic_time(:millisecond)
    total_read_time = end_read - start_read

    # Ensure the time to read/write is acceptable
    # 1,000 reads
    # 1,000 writes
    # Happening in under 200 milliseconds
    # Means we have at least 5 reads and 5 writes per millisecond
    assert total_write_time < 200
    assert total_read_time < 200
  end

  test "read/write same" do
    file_name = "mah_same_file.txt"

    some_data =
      0..1_000
      |> Enum.reduce(fn i, all -> "hi there #{i}" <> "#{all}" end)

    start_time = :erlang.monotonic_time(:millisecond)

    0..1_000
    |> Enum.each(fn _ -> MegaCache.Worker.write_data(file_name, some_data) end)

    0..1_000
    |> Enum.each(fn _ -> MegaCache.Worker.read_data(file_name) end)

    end_time = :erlang.monotonic_time(:millisecond)

    # Ensure we can read/write fast enough
    assert end_time - start_time < 200
  end
end
