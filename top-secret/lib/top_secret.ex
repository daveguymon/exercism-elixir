defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part(ast, acc) do
    accum = 
    case ast do
    {:def, _, [{:when, _,[{method_name, _, params},_]},_]} ->
      get_parts(method_name, params, acc)
    {:defp, _, [{:when, _,[{method_name, _, params},_]},_]} ->
      get_parts(method_name, params, acc)
    {:def, _, [{method_name, _, params}, _]} ->
      case params do
        nil -> ["" | acc]
        [] -> ["" | acc]
        _ -> get_parts(method_name, params, acc)
      end
    {:defp, _, [{method_name, _, params}, _]} ->
      case params do
        nil -> ["" | acc]
        [] -> ["" | acc]
        _ -> get_parts(method_name, params, acc)
      end
    _ ->
      acc
    end

    {ast, accum}
  end

  defp get_parts(method_name, params, acc) do
    arity = Enum.count(params)
    method_prefix = String.slice(to_string(method_name), 0..arity - 1)
    [method_prefix | acc]
  end

  def decode_secret_message(string) do
    string
    |> TopSecret.to_ast
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> Kernel.elem(1)
    |> Enum.reverse
    |> Enum.join
  end
end
