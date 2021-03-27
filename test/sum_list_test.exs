defmodule SumListTest do
  use ExUnit.Case

  describe "call/1" do
    test "return the sum of a list" do
      list = [1, 2, 3]

      response = SumList.call(list)

      expected_response = 6

      assert response == expected_response
    end
  end
end
