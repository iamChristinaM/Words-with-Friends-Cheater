ExUnit.start
defmodule CheaterTest do
  use ExUnit.Case

  test "match" do
    assert Cheater.match('', '')
    refute Cheater.match('', 'a')
    assert Cheater.match('abc','')
    assert Cheater.match('abc','b')
    refute Cheater.match('abc','z')
    assert Cheater.match('abcdef','bdf')
    refute Cheater.match('abc','abcdef')
  end
end

defmodule Cheater do
  def match(tiles, word)do
      match(tiles, word,'')
  end
  def match(_tiles, word,_accumulator) when word =='' do
    true
  end
  def match(tiles, [char | chars], accumulator) do
    if char in tiles do
      match(tiles -- [char], chars, accumulator ++ [char])
    else
      false
    end
  end

  def make_dict(file) do
    {:ok, dict} = File.read(file)
    dict |> String.split("\n") |>
      Enum.map(fn word -> to_charlist word end)
  end

  def matches(tiles,dict) do
    Enum.filter dict, fn word -> match(tiles, word) end
  end
end
