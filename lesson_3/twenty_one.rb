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
# ace_value: value is recalculated with each new_card from the deck
#            if the value of new_card would cause a bust, ace value is 1
#           ( create simulation after thinking about Algorithm)
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
