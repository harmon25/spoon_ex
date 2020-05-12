defmodule SpoonExTest do
  use ExUnit.Case
  doctest SpoonEx

  test "SpoopEx.API.client == Tesla.Client" do
    assert match?(%Tesla.Client{}, SpoonEx.API.client())
  end
end
