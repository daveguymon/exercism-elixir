defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) when is_tuple(ast) do 
    {method, _line, list} = ast
    
    acc = if Regex.match?(~r/\bdefp?\b/, Atom.to_string(method)) do
      [{name, _l1, arguments}, _l3] = list
      arity = Enum.count(arguments || [])
      truncated_name = if arity > 0, do: String.slice(Atom.to_string(name), 0..arity - 1), else: ""
      [truncated_name | acc]
    else
      acc
    end
    
    {ast, acc}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    # Please implement the decode_secret_message/1 function
  end
end