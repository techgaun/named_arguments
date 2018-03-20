defmodule NamedArguments do
  @moduledoc """
  NamedArguments allows you to have python-like named arguments with defaults.

  This module defines two macros (for `def` and `defp`) that can merge passed arguments
  with default values specified in function head.

      defmodule TestModule do
        use NamedArguments

        def func(opts \\ [age: 18, name: "Samar"]) do
          IO.puts opts[:age]
          IO.puts opts[:name]
        end
      end
  """

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2, defp: 2]
      import unquote(__MODULE__)
    end
  end

  for fun_name <- ~w(def defp)a do
    defmacro unquote(fun_name)(defn = {_, _, args}, do: body) do
      fun = unquote(fun_name)
      quote do
        Kernel.unquote(fun)(unquote(defn)) do
          merge_args(unquote(args))
          unquote(body)
        end
      end
    end
  end

  defmacro merge_args(ast) do
    IO.inspect ast
  end
end
