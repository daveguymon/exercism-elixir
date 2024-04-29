defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    bracket_pairs = %{
      ")" => "(",
      "}" => "{",
      "]" => "["
    }

    brackets = 
    str
    |> String.replace(~r/[^\[\]\{\}\(\)]/, "")
    |> String.split("", trim: true)
    
    {open, close} = Enum.reduce(brackets, {[], []}, fn bracket, {openers_acc, closers_acc} -> 
      cond do
        bracket in ["(", "[", "{"] ->
          {[bracket | openers_acc], closers_acc}
        bracket in [")", "]", "}"] ->
          cond do
            List.first(openers_acc) == Map.get(bracket_pairs, bracket) ->
              {List.delete_at(openers_acc, 0), closers_acc}
            true -> {openers_acc, [bracket | closers_acc]}
          end
        true -> {openers_acc, closers_acc}
        end
    end)

    open == [] && close == []
  end
end
