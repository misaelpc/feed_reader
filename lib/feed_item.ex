defmodule Item do
  @moduledoc """
  Documentation for Item.
  """
  defstruct [:link, :title]
  @type t :: %Item{link: String.t(), title: String.t()}

  @link_xpath "//link"
  @title_xpath "//title"

  @spec create([tuple()]) :: [Item.t()]
  def create(items) do
    Enum.map(items, fn(item) ->
      link = FeedParser.query_content(@link_xpath, item)
      title = FeedParser.query_content(@title_xpath, item)
      new(link, title)
    end)
  end

  @spec new(String.t(), String.t()) :: Item.t()
  def new(link, title) do
    %Item{link: link, title: title}
  end
end