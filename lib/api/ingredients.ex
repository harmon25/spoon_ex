defmodule SpoonEx.API.Ingredients do
  @moduledoc """
  Documentation for `SpoonEx.API.Ingredients`.
  """
  alias SpoonEx.API

  @path "/food/ingredients"
  @top1000 "https://spoonacular.com/application/frontend/downloads/top-1k-ingredients.csv"

  @type api_key() :: binary() | nil
  @type id() :: integer() | binary()

  @spec get_information(id(), keyword, api_key()) :: {:error, any} | {:ok, any}
  def get_information(id, opts, api_key \\ nil) do
    valid_opts = Keyword.take(opts, [:amount, :unit])

    API.client(api_key)
    |> API.get(@path <> "/#{id}/information", query: valid_opts)
  end

  @spec list_substitutes(id(), api_key()) :: {:error, any} | {:ok, any}
  def list_substitutes(ingredient_id, api_key \\ nil) do
    API.client(api_key)
    |> API.get(@path <> "/#{ingredient_id}/substitutes")
  end

  @spec list_top(integer) :: [any]
  def list_top(limit \\ 1000) do
    fetch_from_cache()
    |> case do
      nil ->
        {:ok, top1000} = fetch_top()
        put_cache(to_map(top1000))
        top1000

      map ->
        Enum.map(map, fn {_k, v} -> v end)
    end
    |> Enum.take(limit)
  end

  defp fetch_top() do
    case Tesla.get(@top1000) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, parse_top(body)}

      err ->
        err
    end
  end

  defp parse_top(csv) do
    csv
    |> String.split("\n")
    |> Enum.map(fn ingredient_line ->
      [name, id] = String.split(ingredient_line, ";")
      {id, _} = Integer.parse(id)
      %{id: id, name: String.downcase(name)}
    end)
  end

  defp to_map(list) do
    Enum.into(list, %{}, fn ingredient ->
      {ingredient.id, ingredient}
    end)
  end

  defp put_cache(value) do
    :persistent_term.put(__MODULE__.Top1000Cache, value)
  end

  defp fetch_from_cache() do
    :persistent_term.get(__MODULE__.Top1000Cache, nil)
  end
end
