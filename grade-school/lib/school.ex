defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """
  @type school :: any()

  defmodule Student do
    defstruct [:name, :grade]
  end
  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    []
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    student = %Student{name: name, grade: grade}
    if current_student?(student, school) do
      {:error, school}
    else
      {:ok, [student | school]}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    school
    |> sort_students()
    |> Enum.filter(&(&1.grade == grade))
    |> student_names()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> sort_students()
    |> student_names()
  end

  defp current_student?(student, school) do
    school
    |> Enum.any?(&(&1.name == student.name))
  end

  defp sort_students(school) do
    school
    |> Enum.sort_by(fn student -> {student.grade, student.name} end)
  end

  defp student_names(school) do
    school
    |> Enum.reduce([], fn student, acc -> [student.name | acc] end)
    |> Enum.reverse()
  end
end
