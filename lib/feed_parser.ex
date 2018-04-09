defmodule FeedParser do
  @moduledoc """
  Documentation for Parser.
  """
  @child 8
  @text 4

  @spec read_xml(String.t()) :: {:ok, tuple()} | {:error, String.t()}
  def read_xml(xml) do
    xml_list = :erlang.bitstring_to_list(xml)
    try do
      {xml_document, _} = :xmerl_scan.string(xml_list, [{:namespace_conformant, true}])
      {:ok, xml_document}
    catch
      :exit, _ -> {:error, "xml invalido, no puede ser parseado"}
    end
  end

  @spec query_items(String.t(), tuple()) :: [tuple()] | []
  def query_items(xpath, xml) do
    case :xmerl_xpath.string('#{xpath}', xml) do
      [head|tail] -> [head|tail]
      [] -> []
    end
  end

  @spec query_content(String.t(), tuple()) :: String.t()
  def query_content(xpath, xml) do
    [result] = :xmerl_xpath.string('#{xpath}', xml)
    [child] = elem(result, @child)
    child
      |> elem(@text)
      |> to_string
  end

end