defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    Integer.floor_div(score - 10, 2)
  end

  @spec ability :: pos_integer()
  def ability do
    do_multiple_dice_roll(do_single_roll(), 4, [])
    |> Enum.sort()
    |> Enum.drop(1)
    |> Enum.sum
  end

  @spec character :: t()
  def character do
     new_character = %DndCharacter{
      strength: DndCharacter.ability,
      dexterity: DndCharacter.ability,
      constitution: DndCharacter.ability,
      intelligence: DndCharacter.ability,
      wisdom: DndCharacter.ability,
      charisma: DndCharacter.ability,
     }
     Map.put(new_character, :hitpoints, 10 + DndCharacter.modifier(new_character.constitution))
  end

  defp do_single_roll, do: Enum.random(1..6)

  defp do_multiple_dice_roll(_roll, 0, collection), do: collection
  defp do_multiple_dice_roll(roll, times, collection) do
    do_multiple_dice_roll(do_single_roll(), times - 1, [roll | collection])
  end
end
