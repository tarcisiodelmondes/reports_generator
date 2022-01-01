defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @avaliable_foods [
    "pizza",
    "açaí",
    "hambúrguer",
    "esfirra",
    "churrasco",
    "prato_feito",
    "sushi",
    "pastel"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  def fecth_higher_cost(users), do: Enum.max_by(users, fn {_key, value} -> value end)

  defp sum_values([id, food_name, price], %{"users" => users, "foods" => foods} = report) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    %{report | "users" => users, "foods" => foods}
  end

  defp report_acc() do
    foods = Enum.into(@avaliable_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    %{"users" => users, "foods" => foods}
  end
end
