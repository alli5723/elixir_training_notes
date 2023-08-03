defmodule CbnappTest do
  use ExUnit.Case
  doctest Cbnapp

  test "greets the world" do
    assert Cbnapp.hello() == :world
  end
end
