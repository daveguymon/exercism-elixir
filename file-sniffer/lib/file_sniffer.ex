defmodule FileSniffer do
  def type_from_extension("exe"), do: "application/octet-stream"
  def type_from_extension("bmp"), do: "image/bmp"
  def type_from_extension("png"), do: "image/png"
  def type_from_extension("jpg"), do: "image/jpg"
  def type_from_extension("gif"), do: "image/gif"
  def type_from_extension(_extension), do: nil


  def type_from_binary(file_binary) do
    case file_binary do
      <<0x7F, 0x45, 0x4C, 0x46, _rest::binary>> -> 
        "application/octet-stream"
      <<0x42, 0x4D, _rest::binary>> -> 
        "image/bmp"
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _rest::binary>> -> 
        "image/png"
      <<0xFF, 0xD8, 0xFF, _rest::binary>> -> 
        "image/jpg"
      <<0x47, 0x49, 0x46, _rest::binary>> -> 
        "image/gif"
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    binary_file_type = type_from_binary(file_binary)
    extension_file_type = type_from_extension(extension)
    
    do_verify(binary_file_type, extension_file_type)
  end

  defp do_verify(nil, _), do: {:error, "Warning, file format and file extension do not match."}
  
  defp do_verify(binary_file_type, extension_file_type) do
    if(binary_file_type == extension_file_type) do
      {:ok, extension_file_type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end 
  end

  
end
