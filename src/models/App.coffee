# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    console.dir(@get 'dealerHand')
    window.checker = @get 'dealerHand'
    @get('dealerHand').on "dealerHasBlackJack", ->
      @dealerHasBlackJack()
    @get('playerHand').on("bust", ->@bust())
    return
  dealerHasBlackJack: ->
    ###
    Check the score of player hand
    if it is 21 trigger a push
      else
        trigger lose
    ###
    maxScore = Math.max(@get 'playerHand'.scores())
    if maxScore is 21
      @trigger("push")

    else
      @trigger("lose")

  showDown: (dealerHand, playerHand) ->

  bust: ->
    console.log "lose"
    @trigger("lose")

