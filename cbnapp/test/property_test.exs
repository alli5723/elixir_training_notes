defmodule MyPropertyTest do
  use ExUnitProperties
  use ExUnit.Case, async: true

  property "the in/2 operator works with lists" do
    check all list <- list_of(term()),
              list != [],
              elem <- member_of(list) do
      assert elem in list
    end
  end

  property "bin1 <> bin2 always starts with bin1" do
    check all bin1 <- binary(),
              bin2 <- binary() do
      assert String.starts_with?(bin1 <> bin2, bin1)
    end
  end
end
