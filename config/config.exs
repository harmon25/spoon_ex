import Config

config :spoon_ex,
  adapter: Tesla.Adapter.Hackney,
  adapter_opts: [],
  api_key: System.get_env("SPOONACULAR_API_KEY")
