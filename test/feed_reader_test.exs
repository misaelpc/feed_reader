defmodule FeedReaderTest do
  use ExUnit.Case
  doctest FeedReader

  test "greets the world" do
    assert FeedReader.hello() == :world
  end
end
