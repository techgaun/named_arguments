defmodule NamedArgumentsTest do
  use ExUnit.Case

  defmodule TestModule do
    use NamedArguments

    def no_args, do: :ok

    def no_default_args(opts), do: opts

    def default_arg(opts \\ [name: "Samar", age: 18]), do: opts

    def default_list_arg(nums \\ [1, 2, 3]), do: nums

    def multi_args(arg1, arg2), do: {arg1, arg2}

    def multi_last_default_arg(arg1, opts \\ [name: "Samar", age: 18]), do: {arg1, opts}

    def multi_default_args(age \\ 18, name \\ "Samar"), do: {age, name}

    def multi_kw_default_args(person \\ [name: "Samar", age: 18], opts \\ [power: :nothing]),
      do: {person, opts}

    def map_args(opts \\ %{name: "Samar", age: 18}), do: opts
  end

  test "no args" do
    assert TestModule.no_args() === :ok
  end

  test "no default args" do
    assert TestModule.no_default_args("hello") === "hello"
    assert TestModule.no_default_args([1, 2]) === [1, 2]
    assert TestModule.no_default_args(name: "Samar", age: 18) === [name: "Samar", age: 18]
  end

  test "default arg" do
    assert TestModule.default_arg(name: "Samar", age: 18) === TestModule.default_arg()
    assert TestModule.default_arg(name: "Hello") === [age: 18, name: "Hello"]
  end

  test "default normal list arg" do
    assert TestModule.default_list_arg() === [1, 2, 3]
    assert TestModule.default_list_arg([1, 2]) === [1, 2]
  end

  test "multi args" do
    assert TestModule.multi_args(1, 2) === {1, 2}
  end

  test "multi with last default args" do
    assert TestModule.multi_last_default_arg(:person) === {:person, [name: "Samar", age: 18]}

    assert TestModule.multi_last_default_arg(:person, name: "Hello") ===
             {:person, [age: 18, name: "Hello"]}
  end

  test "multi default args" do
    assert TestModule.multi_default_args() === TestModule.multi_default_args(18, "Samar")
    assert TestModule.multi_default_args(26) === {26, "Samar"}
  end

  test "multi keyword list default args" do
    person = [name: "Hello", age: 25]
    opts = []

    assert TestModule.multi_kw_default_args(person, opts) === {person, [power: :nothing]}
  end

  test "map default args" do
    opts = %{name: "Hello"}
    assert %{name: "Hello", age: 18} === TestModule.map_args(opts)
  end
end
