defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @codon_map %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(""), do: {:ok, []}
  
  def of_rna(rna) do
    codon_list =
    String.split(rna, "", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join/1)
    |> Enum.take_while(fn codon -> codon not in ["UAA", "UAG", "UGA"] end)

    try do
      translations = for codon <- codon_list do
        if validate_codon(codon) do
          translate_codon_to_protein(codon)
        else
          throw(:invalid_codon)
        end
      end
      {:ok, translations}
    catch
      :invalid_codon -> {:error, "invalid RNA"}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    validated_codon = validate_codon(codon)

    case validated_codon do 
      true -> 
        {:ok, translate_codon_to_protein(codon)}
      _ ->
        {:error, "invalid codon"}
    end   
  end

  defp validate_codon(codon) do
    Map.has_key?(@codon_map, codon)
  end

  defp translate_codon_to_protein(codon) do
    Map.get(@codon_map, codon)
  end
end
