# named_arguments [![Build Status](https://travis-ci.org/techgaun/named_arguments.svg?branch=master)](https://travis-ci.org/techgaun/named_arguments)

> Named arguments in Elixir

This package abuses macros to use keyword lists
to mimic named arguments in Elixir.

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

You can check the [test](test/named_arguments_test.exs) for more examples.
