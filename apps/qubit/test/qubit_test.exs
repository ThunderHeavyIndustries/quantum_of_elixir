defmodule QubitTest do
  use ExUnit.Case
  doctest Qubit

  test "greets the world" do
    assert Qubit.hello() == :world
  end
end
