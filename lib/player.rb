require_relative "card"

class Player
  attr_reader :name
  attr_accessor :hand, :books

  def initialize (name, hand = [])
    @name = name
    @hand = hand
    @books = 0
  end

  def has_card?(rank)
    hand.include?(Card.new(rank))
  end

  def give_cards(rank)
    removed_cards = []
    hand.each do |card|
      if card.rank == rank
        removed_cards.push(card)
      end
    end
    self.hand -= removed_cards
    removed_cards
  end

  def cards_left
    hand.count
  end

  def check_cards_left(deck)
    if cards_left == 0 && deck.cards_left > 0
      take_cards([deck.deal])
    end
  end

  def take_cards (cards)
    hand.concat(cards)
    check_for_books
  end

  def check_for_books
    rank_frequency = {}
    hand.each do |card|
      increase_rank_frequency(rank_frequency, card)
    end
    rank_frequency.each do |rank, frequency|
      if frequency == 4
        hand.delete(Card.new(rank))
        self.books += 1
      end
    end
  end

  def increase_rank_frequency(rank_frequency, card)
    if rank_frequency.key?(card.rank)
      rank_frequency[card.rank] += 1
    else
      rank_frequency[card.rank] = 1
    end
  end
end