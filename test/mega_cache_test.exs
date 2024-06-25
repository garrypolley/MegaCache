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
    0..1_000
    |> Enum.map(fn i -> MegaCache.Worker.write_data("hello_#{i}", "some random data") end)

    0..1_000
    |> Enum.map(fn i ->
      assert MegaCache.Worker.read_data("hello_#{i}") === "some random data"
    end)
  end
end
