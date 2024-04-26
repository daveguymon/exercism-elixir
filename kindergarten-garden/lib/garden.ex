defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @seeds %{
    "G" => :grass,
    "C" => :clover,
    "R" => :radishes,
    "V" => :violets
  }

  @student_names [
    :alice, :bob, :charlie, 
    :david, :eve, :fred, 
    :ginny, :harriet, :ileana, 
    :joseph, :kincaid, :larry
  ]

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @student_names) do
    sorted_roster = Enum.sort(student_names)
    classroom_garden = generate_student_garden(sorted_roster)

    [row1, row2] = 
    info_string
    |> String.split("\n")
    |> Enum.map(&split_string_into_equal_parts(&1) |> Enum.reverse)

    
    plants_by_student = for {set1, set2} <- Enum.zip(row1, row2) do
      set1 <> set2
      |> String.split("", trim: true)
      |> Enum.map(&Map.get(@seeds, &1))
      |> List.to_tuple
    end

    pair_plants_with_students(sorted_roster, plants_by_student, classroom_garden)
  end

  defp split_string_into_equal_parts(string, collection \\ [])
  defp split_string_into_equal_parts("", collection), do: collection
  defp split_string_into_equal_parts(string, collection) do
    {part, rest} = String.split_at(string, 2)
    updated_collection = [part | collection]
    split_string_into_equal_parts(rest, updated_collection)
  end

  defp pair_plants_with_students([], [], acc), do: acc
  defp pair_plants_with_students(_student_names, [], acc), do: acc
  defp pair_plants_with_students([student | class], [plant | garden], acc) do
    assignment = 
    Map.put(acc, student, plant)
    pair_plants_with_students(class, garden, assignment)
  end

  defp generate_student_garden(student_names) do
    Map.from_keys(student_names, {})
  end
end
