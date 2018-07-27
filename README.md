# named_arguments [![Hex version](https://img.shields.io/hexpm/v/named_arguments.svg "Hex version")](https://hex.pm/packages/named_arguments) ![Hex downloads](https://img.shields.io/hexpm/dt/named_arguments.svg "Hex downloads") [![Build Status](https://travis-ci.org/techgaun/named_arguments.svg?branch=master)](https://travis-ci.org/techgaun/named_arguments)

> Named arguments in Elixir

This package abuses macros to use keyword lists
and maps to mimic named arguments in Elixir.

The usage is very simple:

```elixir
defmodule Analyzer do
  use NamedArguments

  def query(opts \\ [aggregate: :sum, range: "1h"]) do
    IO.puts "running query with #{opts[:aggregate]} over range #{opts[:range]}"
  end
end

Analyzer.query()
# running query with sum over range 1h

Analyzer.query(aggregate: :avg)
# running query with avg over range 1h
```

While the above example shows Keyword list example, this works fine with maps as well.

You can check the [test](test/named_arguments_test.exs) for more examples.
