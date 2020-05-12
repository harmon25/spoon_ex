defmodule SpoonEx do
  @moduledoc """
  Documentation for `SpoonEx`.
  """

  @type api_key() :: binary() | nil
  @type id() :: integer() | binary()

  @doc """
  List Recipes

  https://spoonacular.com/food-api/docs#Search-Recipes

  ## Examples

      iex> {:ok, result} = SpoonEx.search_recipes("burgers")

  """
  @spec search_recipes(any, keyword, api_key()) :: {:error, any} | {:ok, any}
  defdelegate search_recipes(query, opts \\ [], api_key \\ nil),
    to: SpoonEx.API.Recipes,
    as: :search

  @doc """
  Fetch recipe information
  https://spoonacular.com/food-api/docs#Get-Recipe-Information

  ## Examples

      iex> {:ok, result} = SpoonEx.recipe_info(245166)

  """
  @spec recipe_info(any, keyword, api_key) :: {:error, any} | {:ok, any}
  defdelegate recipe_info(recipe_id, opts \\ [], api_key \\ nil),
    to: SpoonEx.API.Recipes,
    as: :get_information

  @doc """
  Fetch recipes based on a list of ingredients

  https://spoonacular.com/food-api/docs#Search-Recipes-by-Ingredients

  ## Examples

      iex> {:ok, result} = SpoonEx.recipes_by_ingredient(["apples"])

  """
  @spec recipes_by_ingredient(any, keyword, api_key()) :: {:error, any} | {:ok, any}
  defdelegate recipes_by_ingredient(ingredients, opts \\ [], api_key \\ nil),
    to: SpoonEx.API.Recipes,
    as: :by_ingredients

  @doc """
  List recipe ingredients


  ## Examples

      iex> {:ok, result} = SpoonEx.recipe_ingredients(245166)

  """
  @spec recipe_ingredients(id(), api_key()) :: {:error, any} | {:ok, any}
  defdelegate recipe_ingredients(recipe_id, api_key \\ nil),
    to: SpoonEx.API.Recipes,
    as: :list_ingredients

  @doc """
  List recipe equipment


  ## Examples

      iex> {:ok, result} = SpoonEx.recipe_equipment(245166)

  """
  @spec recipe_equipment(id, api_key()) :: {:error, any} | {:ok, any}
  defdelegate recipe_equipment(recipe_id, api_key \\ nil),
    to: SpoonEx.API.Recipes,
    as: :list_equipment

  @doc """
  Get Ingredient information


  ## Examples

      iex> {:ok, result} = SpoonEx.ingredient_info(9266)

  """
  @spec ingredient_info(id(), keyword(), api_key()) :: {:error, any} | {:ok, any}
  defdelegate ingredient_info(ingredient_id, opts \\ [], api_key \\ nil),
    to: SpoonEx.API.Ingredients,
    as: :get_information

  @doc """
  Get Ingredient substitues by name


  ## Examples

      iex> {:ok, result} = SpoonEx.ingredient_substitutes("butter")

  """
  @spec ingredient_substitutes(id(), api_key()) :: {:error, any} | {:ok, any}
  defdelegate ingredient_substitutes(ingredient_name, api_key \\ nil),
    to: SpoonEx.API.Ingredients,
    as: :list_substitutes

  @doc """
   Search products by query


  ## Examples

      iex> {:ok, result} = SpoonEx.search_products("butter")

  """
  @spec search_products(binary(), keyword(), api_key()) :: {:error, any} | {:ok, any}
  defdelegate search_products(ingredient_name, opts \\ [], api_key \\ nil),
    to: SpoonEx.API.Products,
    as: :search

  @doc """
   Fetch a product by UPC


  ## Examples

      iex> {:ok, result} = SpoonEx.product_by_upc("041631000564")

  """
  @spec product_by_upc(binary(), api_key()) :: {:error, any} | {:ok, any}
  defdelegate product_by_upc(ingredient_name, api_key \\ nil),
    to: SpoonEx.API.Products,
    as: :by_upc
end
