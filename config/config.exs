import Config

config :spoon_ex,
  adapter: Tesla.Adapter.Httpc,
  adapter_opts: [],
  api_key: System.get_env("SPOONACULAR_API_KEY")
