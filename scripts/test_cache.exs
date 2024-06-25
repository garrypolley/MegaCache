defmodule TestCacheRequester do
  def test_create do
    data = Poison.Encoder.encode(%{
      "key" => 123,
      "otehr key" => "some other",
      "key depth" => %{
        "go deeper key" => 456
      }
    }, %{})
    case HTTPoison.post(
      "http://localhost:8808/cache/#{random_key()}",
      data,
      [{"Content-Type", "application/json"}]
    ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp random_key do
    prefix = :rand.uniform(10)
    key = :peer.random_name(prefix)
    "#{prefix}_#{key}"
    |> IO.inspect()
  end
end

TestCacheRequester.test_create()
