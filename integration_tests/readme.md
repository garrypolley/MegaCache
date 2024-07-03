This is a custom set of code that creates/runs an integration test suite. 

It's currently Python, but can/could be elixir in a bit.


there is an Elixir based test in the `scripts/test_cache.exs` -- this can be run by doing `mix run scripts/test_cache.exs`. Mostly here to make it easier to verify things are running the API.

Because it uses Mix, it starts up the application before running the script.
