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

  defmacro merge_args([]), do: nil

  defmacro merge_args(nil), do: nil

  defmacro merge_args([{:\\, _, [var_key, {:%{}, _, default_args}]} | rest])
           when is_list(default_args) do
    quote do
      var!(unquote(var_key)) =
        Map.merge(Enum.into(unquote(default_args), %{}), var!(unquote(var_key)))

      merge_args(unquote(rest))
    end
  end

  defmacro merge_args([{:\\, _, [var_key, default_args]} | rest]) when is_list(default_args) do
    quote do
      var!(unquote(var_key)) =
        cond do
          Keyword.keyword?(unquote(default_args)) ->
            Keyword.merge(unquote(default_args), var!(unquote(var_key)))

          true ->
            var!(unquote(var_key))
        end

      merge_args(unquote(rest))
    end
  end

  defmacro merge_args([_ | rest]) do
    quote do: merge_args(unquote(rest))
  end
end
