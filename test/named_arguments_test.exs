defmodule NamedArgumentsTest do
  use ExUnit.Case
  doctest NamedArguments

  test "greets the world" do
    assert NamedArguments.hello() == :world
  end
end
