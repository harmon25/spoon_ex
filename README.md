# SpoonEx

Elixir Spoonacular Food API Client - Built with Tesla

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `spoon_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:spoon_ex, "~> 0.1.0"}
  ]
end
```

Add this or similar to config exs to setup tesla adapter and api key

```elixir
config :spoon_ex,
  adapter: Tesla.Adapter.Hackney,
  adapter_opts: [],
  api_key: System.get_env("SPOONACULAR_API_KEY")
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/spoon_ex](https://hexdocs.pm/spoon_ex).
