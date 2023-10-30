def prepare_deck
  cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
  cards.each_with_object([]) do |card, deck|
    4.times { deck << card }
  end
end

def draw_card!(deck, hand)
  hand << deck.shift
end

def hit_or_stay
  puts "Would you like to hit or stay? (h for hit, s for stay)"
  answer = gets.chomp
end

def hand(cards)
  cards.each_with_object("") do |card, hand|
    hand << if card == cards[-2]
              "#{card} and "
            elsif card == cards[-1]
              "#{card}"
            else
              "#{card}, "
            end
  end
end

def total(hand)
  sum = 0
  hand.each do |card|
    sum += if card == 'Ace'
             11
           elsif card.is_a?(String)
             10
           else
             card.to_i
           end
  end

  hand.count('Ace').times { sum -= 10 if sum > 21 }
  sum
end

def bust?(total)
  total > 21
end

def deal_cards(deck, dealer, player)
  draw_card!(deck, player)
  draw_card!(deck, dealer)
  draw_card!(deck, player)
  draw_card!(deck, dealer)
end

# prepare the deck
deck = prepare_deck.shuffle

# dealer and player have empty hands
player_hand = []
dealer_hand = []

# deal cards
deal_cards(deck, dealer_hand, player_hand)

puts "Dealer has: #{dealer_hand.first} and unknown card"

# player_turn
loop do
  total = total(player_hand)
  puts "Your hand is #{hand(player_hand)}"
  if bust?(total)
    puts "your total was #{total}, you lose!"
    return
  end
  choice = hit_or_stay
  break if choice == 's'
  draw_card!(deck, player_hand)
end

# dealers turn
loop do
  total = total(dealer_hand)
  if bust?(total)
    puts "dealer's hand is #{total}, you win!"
    return
  end
  break if total >= 17
  draw_card!(deck, dealer_hand)
end

# display hands
puts "let's see em'!"
puts "Player has: #{hand(player_hand)}"
puts "Dealer has: #{hand(dealer_hand)}"

# compare hands
dealer_hand_value = total(dealer_hand)
player_hand_value = total(player_hand)
puts "Dealer has #{dealer_hand_value}, you have #{player_hand_value}"

# declare winner
if player_hand_value > dealer_hand_value
  puts "you win!"
elsif dealer_hand_value > player_hand_value
  puts "you lose!"
else
  puts "my my, its a tie!"
end
