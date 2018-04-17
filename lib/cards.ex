defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """
  
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # for value <- values, suit <- suits do
    for suit <- suits, value <- values do
      # IO.puts "#{value} of #{suit}"
        "#{value} of #{suit}"
    end
  end
  
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """

  def contains?(deck, hand) do
    # Master method to pass arguments to. The FP way of doing things!
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck. 
    The `hand_size` argument indicates how many cards should 
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    # Enum.split(enumerable, count)
    # Count is number we want in the first list, remainder stuffed in the second list
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    # How to evoke erlang code (:erlang)
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      # Pattern matching makes this work! File.read(filename) returns a tuple that will match against these scenarios
      {:ok, binary} -> :erlang.binary_to_term binary
      # The underscore tells elixir we know there will be something there but we do not care about it
      {:error, _reason} -> "That file does not exist"
      # :ok, and :error is a primitive data type known as an "atom"
      # atoms are used throughout elixir for handling control flow throughout the app
      # think of atoms as exactly like strings
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
