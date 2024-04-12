defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    transcription_map = %{
      ?G => ?C,
      ?C => ?G,
      ?T => ?A,
      ?A => ?U,
    }

    for nuc <- dna do 
      transcription_map[nuc]
    end
    |> List.to_charlist()
  end
end
