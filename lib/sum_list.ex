defmodule SumList do
  def call(list), do: sum(list)

  def call_enum(list), do: Enum.any?(list, fn elem -> elem > 5 end)

  defp sum([]), do: 0

  defp sum([head | tail]) do
    head + sum(tail)
  end
end
