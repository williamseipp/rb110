# Problem
# you start with a 52-card deck ( all suits, 13 values in each suit)
# goal is to get as CLOSE to 21 but NOT over. If you get over 21 you BUST
# 1. there is a "dealer" and a "player"
# 2. 2 cards each are dealt to "dealer" and "player", for a total of 4 cards
#     player can see both of their 2 cards, but only see 1 of the dealer's
# 3. player goes first
# 4. PLAYER'S TURN:
#       prompted to HIT or STAY
#         HIT:
#           each new_card is visible to player
#           hand_value is calculated each time
#         STAY: player's turn ends
#
# 5. DEALER'S TURN:
#       dealer chooses HIT repeatedly until total is at least 17
#       hand_value is calculated each time
#
# 6. COMPARE phase: after dealer's turn , compare value of each
#     hand to determine who's is highest
#
# CARD VALUES: 2-10 = 2-10, JQK = 10, ace 1 or 11
#
# aces_value: add the total value for all cards; aces are 11
#           for however many aces you have, keep subtracting 10 from
#           the total value of the cards if the sum is over 21
#
# QUESTIONS:
#
# Q:  what happens if you tie the dealer's hand?
# A:  they tie ( known as a 'push' or 'standoff')
#
# Q:  how is ace_value calculated when there are 2, 3, and 4 aces?
# A:  calculate the value of the other cards in your hand that are not aces
#     then, subtract this value from 21: this will be the "remainder"
#     calculate the value of aces based on the remainder
#
#     1. if you have one ace and the remainder is 11 or greater,
#         aces_value is 11. if not, it is 1
#
#     2. if you have two aces and the remainder is 12 or greater
#         aces_value is 12. if not, it is 2
#
#     3. if you have three aces and the remainder is 13 or greater
#         aces_value is 13. if not, it is 3
#
#     4. if you have four aces and the remainder is 14 or greater
#         aces_value is 14. if not, it is 4
#
# Data
# Algorithm
# Code

def prepare_deck
  cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, "jack", "queen", "king", "ace"]
  suits = ["hearts", "diamonds", "spades", "clubs"]
  cards.each_with_object([]) do |card, deck|
    suits.each do |suit|
      deck << "#{card} of #{suit}"
    end
  end
end

def deal_card!(deck, hand)
  hand << deck.shift
end

def draw_card!(deck, hand)
  hand << deck.shift
end

def hit_or_stay
  puts "Would you like to hit or stay? (h for hit, s for stay)"
  answer = gets.chomp
end

def display_initial_hands(dealer_hand, player_hand)
  puts "Dealer has: #{dealer_hand.first} and unknown card"
  puts "You have: #{player_hand}"
end

def display_hands(dealer_hand, player_hand)
  puts "#{dealer_hand}"
  puts "#{player_hand}"
end

def total(_hand)
  values = [20, 24, 17, 7]
  values.sample
end

def bust?(total)
  total > 21
end

# prepare the deck
deck = prepare_deck.shuffle

# dealer and player have empty hands
player_hand = []
dealer_hand = []

# deal 4 cards at start of game, 2 to each player
deal_card!(deck, player_hand)
deal_card!(deck, dealer_hand)
deal_card!(deck, player_hand)
deal_card!(deck, dealer_hand)

# display cards
display_initial_hands(dealer_hand, player_hand)

# player_turn
loop do
  total = total(player_hand)
  puts "your hand is #{player_hand}"
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
display_hands(dealer_hand, player_hand)

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

