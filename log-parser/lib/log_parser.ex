defmodule LogParser do
  def valid_line?(line) do
    ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
    |> Regex.match?(line)
  end

  def split_line(line) do
    ~r/\<[~*=-]*\>/
    |> Regex.split(line)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line(\d+)/i, "", global: true)
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+([^\s]+)/, line) do
      [_, captured_word] -> "[USER] #{captured_word} #{line}"
      nil -> line
    end
  end
end
