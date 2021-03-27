defmodule SumList do
  def call(list), do: sum(list)

  defp sum([]), do: 0

  defp sum([head | tail]) do
    head + sum(tail)
  end
end
