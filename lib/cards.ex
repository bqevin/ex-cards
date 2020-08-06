defmodule Cards do
  @moduledoc """
  Documentation for `Cards` game - basic functions.
  """

  @doc """
  Creates a deck with suits

  ## Examples

      iex> Cards.create_deck()
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
      "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffles a deck

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.shuffle(deck)
      ["Five of Hearts", "Ace of Clubs", "Four of Clubs", "Five of Diamonds",
      "Four of Spades", "Three of Clubs", "Ace of Diamonds", "Two of Diamonds",
      "Three of Diamonds", "Five of Clubs", "Three of Spades", "Two of Clubs",
      "Two of Hearts", "Five of Spades", "Four of Diamonds", "Two of Spades",
      "Three of Hearts", "Four of Hearts", "Ace of Hearts", "Ace of Spades"]

  """
  def shuffle(deck \\ []) do
    Enum.shuffle(deck)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.

  The `hand_size` arguments indicates how many cards should be in hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, rest_of_deck} = Cards.deal(deck, 2)
      {["Five of Hearts", "Ace of Clubs"],
      ["Four of Clubs", "Five of Diamonds", "Four of Spades", "Three of Clubs",
      "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds", "Five of Clubs",
      "Three of Spades", "Two of Clubs", "Two of Hearts", "Five of Spades",
      "Four of Diamonds", "Two of Spades", "Three of Hearts", "Four of Hearts",
      "Ace of Hearts", "Ace of Spades"]}
      iex> hand
      ["Five of Hearts", "Ace of Clubs"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Checks if a card is in deck

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Four of Hearts")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Saves a deck into a local file with provided name

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.save(deck, "my_deck_of_cards")
      :ok
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Load a local deck file of provided name

  ## Examples

      iex> Cards.load("my_deck_of_cards")
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
      "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "file with the name not found"
    end
  end

  @doc """
  Creates a hand in one step, provided a size

  ## Examples

      iex> {hand, rest_of_deck} = Cards.create_hand(4)

  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
