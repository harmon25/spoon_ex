defmodule SpoonEx.API.Recipes do
  @moduledoc """
  Documentation for `SpoonEx.API.Recipes`.
  """
  alias SpoonEx.API

  @path "/recipes"
  @type api_key() :: binary() | nil

  @spec search(any, keyword, api_key()) :: {:error, any} | {:ok, any}
  def search(query, opts \\ [], api_key \\ nil) do
    API.client(api_key)
    |> API.get(@path <> "/search", Keyword.merge([query: query], opts))
  end

  @spec by_ingredients(any, any, any) :: {:error, any} | {:ok, any}

  def by_ingredients(ingredients, opts \\ [], api_key \\ nil)

  def by_ingredients([], _, _) do
    {:ok, []}
  end

  def by_ingredients(ingredients, opts, api_key) do
    API.client(api_key)
    |> API.get(@path <> "/findByIngredients",
      query: Keyword.merge([ingredients: ingredients], opts)
    )
  end

  @spec get_information(any, keyword, api_key()) :: {:error, any} | {:ok, any}
  def get_information(id, opts, api_key \\ nil) do
    include_nutrition? = Keyword.get(opts, :include_nutrition, false)

    API.client(api_key)
    |> API.get(@path <> "/#{id}/information", query: [includeNutrition: include_nutrition?])
  end

  @spec list_ingredients(any, api_key()) :: {:error, any} | {:ok, any}
  def list_ingredients(recipe_id, api_key \\ nil) do
    API.client(api_key)
    |> API.get(@path <> "/#{recipe_id}/ingredientWidget.json")
  end

  @spec list_equipment(any, api_key()) :: {:error, any} | {:ok, any}
  def list_equipment(recipe_id, api_key \\ nil) do
    API.client(api_key)
    |> API.get(@path <> "/#{recipe_id}/equipmentWidget.json")
  end
end
