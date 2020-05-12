defmodule SpoonEx.API.Products do
  @moduledoc """
  Documentation for `SpoonEx.API.Products`.
  """
  alias SpoonEx.API

  @path "/food/products"
  @type api_key() :: binary() | nil

  @spec search(any, keyword, api_key()) :: {:error, any} | {:ok, any}
  def search(query, opts, api_key \\ nil) do
    number = Keyword.get(opts, :number, 10)

    API.client(api_key)
    |> API.get(@path <> "/search", Keyword.merge([query: query, number: number], opts), [])
  end

  @spec by_upc(binary(), api_key()) :: {:error, any} | {:ok, any}
  def by_upc(upc, api_key \\ nil) do
    API.client(api_key)
    |> API.get(@path <> "/upc/#{upc}")
  end
end
