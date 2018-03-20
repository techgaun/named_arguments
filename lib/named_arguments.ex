defmodule NamedArguments do
  @moduledoc """
  NamedArguments allows you to have python-like named arguments with defaults.
  """

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2, defp: 2]
      import unquote(__MODULE__)
    end
  end

  for fun_name <- ~w(def defp)a do
    defmacro unquote(fun_name)(defn = {_, _, _}, do: body) do
      fun = unquote(fun_name)
      quote do
        Kernel.unquote(fun)(unquote(defn)) do
          unquote(body)
        end
      end
    end
  end
end
