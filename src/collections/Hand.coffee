class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
  ###
  if isDealer is true and the upcard is an Ace
    check if dealer has blackjack
    if the dealer has blackjack
      trigger the dealer has blackjack event
  ###
  if @isDealer is true and array[1].get("rankName") is "Ace"
    switch array[0].get("rankName")
      when 10, "Jack", "Queen", "King", "Ace"
        @trigger("dealerHasBlackJack")

  hit: ->
    @add(@deck.pop())
    if @isDealer is false
      if @minScore() > 21
        @trigger("bust")

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


