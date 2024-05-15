defmodule TwelveDays do
  @gifts %{
    1 => ["first", "a Partridge in a Pear Tree"],
    2 => ["second", "two Turtle Doves"],
    3 => ["third", "three French Hens"],
    4 => ["fourth", "four Calling Birds"],
    5 => ["fifth", "five Gold Rings"],
    6 => ["sixth", "six Geese-a-Laying"],
    7 => ["seventh", "seven Swans-a-Swimming"],
    8 => ["eighth", "eight Maids-a-Milking"],
    9 => ["ninth", "nine Ladies Dancing"],
    10 => ["tenth", "ten Lords-a-Leaping"],
    11 => ["eleventh", "eleven Pipers Piping"],
    12 => ["twelfth", "twelve Drummers Drumming"]
  }
  
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    [current_day, _gift] = Map.get(@gifts, number)
    
    previous_gifts = 
    if number > 1 do 
      Enum.reverse(2..number) 
      |> Enum.map(&List.last(Map.get(@gifts, &1))) 
      |> Enum.join(", ")
    end

    gift_collection = 
    if previous_gifts do
      "#{previous_gifts}, and #{List.last(Map.get(@gifts, 1))}"
    else
      "#{List.last(Map.get(@gifts, 1))}"
    end
    
    "On the #{current_day} day of Christmas my true love gave to me: #{gift_collection}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.map(starting_verse..ending_verse, &verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
