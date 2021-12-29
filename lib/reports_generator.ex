defmodule ReportsGenerator do
  def build(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Enum.reduce(report_acc(), fn line, report ->
      [id, food_name, price] = parse_line(line)
      [_food_name, price_now] = report[id]
      Map.put(report, id, [food_name, price_now + price])
    end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end

  defp report_acc(), do: Enum.into(1..30, %{}, &{Integer.to_string(&1), ["", 0]})
end
