# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerWins', 0
    @set 'dealerWins', 0

    @listenTo (@get "dealerHand"),"checkWin",@checkWin
    @listenTo (@get "playerHand"),"checkWin",@checkWin


    @listenTo (@get "dealerHand"),"checkStand",@checkStand
    @listenTo (@get "playerHand"),"checkStand",@checkStand
    return
  
  playerScore:()-> 
    @get('playerHand').scores()
  
  dealerScore:()-> 
    @get('dealerHand').scores()

  dealerWin:()->
    @set('dealerWins', (@get 'dealerWins')+1) 
  playerWin:()->
    @set('playerWins', (@get 'playerWins')+1) 

  checkWin:()->
    if @playerScore()[0] > 21
      @dealerWin()
      console.log @playerScore()
      console.log "Win! dealer"
      @resetDeck()
      return @trigger('winDetected')

    if @playerScore()[0] == 21
      @playerWin()
      console.log "Win! player"
      @resetDeck()
      return @trigger('winDetected') 

    if @dealerScore()[0] < @playerScore()[0] && @playerScore()[0] < 21  && @dealerScore()[0] < 21
      console.log "Win condition not detected"
      return

    if @dealerScore()[0] > @playerScore()[0] && @dealerScore()[0] <= 21
      @playerWin()
      console.log "Win! dealer"
      @resetDeck()
      return @trigger('winDetected')

  checkStand:()->
    if @dealerScore()[0] > @playerScore()[0] && @dealerScore()[0] <= 21
      @dealerWin()
      console.log "Win! dealer"
      @resetDeck()
      return @trigger('winDetected')
    else
      @playerWin()
      console.log "Win! Player"
      @resetDeck()
      return @trigger('winDetected')      

  resetDeck:()->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @listenTo (@get "dealerHand"),"checkWin",@checkWin
    @listenTo (@get "playerHand"),"checkWin",@checkWin

