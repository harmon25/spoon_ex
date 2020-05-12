defmodule SpoonEx.API do
  @moduledoc """
  Documentation for `SpoonEx.API`.
  """

  @baseurl "https://api.spoonacular.com"

  @spec get(Tesla.Client.t(), binary, any, any) :: {:error, any} | {:ok, any}
  def get(client, url, query_params, _opts \\ []) do
    case Tesla.get(client, url, query: query_params) do
      {:ok, %{status: 200, body: body}} -> {:ok, body}
      err -> err
    end
  end

  @spec get(Tesla.Client.t(), binary) :: {:error, any} | {:ok, any}
  def get(client, url) do
    case Tesla.get(client, url) do
      {:ok, %{status: 200, body: body}} -> {:ok, body}
      err -> err
    end
  end

  @spec client(binary() | nil) :: Tesla.Client.t()
  def client(nil) do
    client()
  end

  def client(api_key) do
    do_middleware(api_key)
    |> Tesla.client(do_adapter())
  end

  @spec client :: Tesla.Client.t()
  def client() do
    Application.get_env(:spoon_ex, :api_key)
    |> do_middleware()
    |> Tesla.client(do_adapter())
  end

  defp do_middleware(api_key) do
    [
      {Tesla.Middleware.BaseUrl, @baseurl},
      {Tesla.Middleware.Query, apiKey: api_key},
      Tesla.Middleware.JSON
    ]
  end

  defp do_adapter() do
    {Application.get_env(:spoon_ex, :adapter, Tesla.Adapter.Httpc),
     Application.get_env(:spoon_ex, :adapter_opts, [])}
  end
end
