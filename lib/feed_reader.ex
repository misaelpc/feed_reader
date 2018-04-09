defmodule FeedReader do
  @moduledoc """
  Documentation for FeedReader.
  """
  @aristegui_feed "https://aristeguinoticias.com/feed/"
  @item_xpath "//item"

  def consume do
    with {:ok, raw_body} <- download(@aristegui_feed),
         {:ok, xml} <- FeedParser.read_xml(raw_body) do
      items = FeedParser.query_items(@item_xpath, xml)
      Item.create(items)
    else
      error ->
        error
    end
  end

  @spec download(String.t()) :: {:ok, String.t()}
  def download(feed) do
    reponse = HTTPotion.get feed
    {:ok, reponse.body}
  end
end
