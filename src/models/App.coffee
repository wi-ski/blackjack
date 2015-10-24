# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck();
    @set 'playerHand', deck.dealPlayer();
    @set 'dealerHand', deck.dealDealer();
    @set 'playerWins', 0
    @set 'dealerWins', 0

    @listenTo (@get "dealerHand"),"checkWin",@checkWin
    @listenTo (@get "playerHand"),"checkWin",@checkWin
    return
  
  playerScore:()-> 
    @get('playerHand').scores();
  
  dealerScore:()-> 
    @get('dealerHand').scores();

  win:(person)->
    @trigger('disableButtons')
    @set( person+'Wins', (@get person+'Wins')+1) 

  checkWin:(stand)->
    if @playerScore()[0] == 21
      @win("player");
      setTimeout @resetDeck.bind(@),3000
      console.log "Win! player"
    else if @dealerScore()[0] == 21
      @win("dealer");
      setTimeout @resetDeck.bind(@),3000
      console.log "Win! dealer"
    else if @playerScore()[0] > 21
      @disableButtons
      @win("dealer");
      setTimeout @resetDeck.bind(@),3000
      console.log "Win! dealer"
    else if @dealerScore()[0] > 21
      @win("player");
      setTimeout @resetDeck.bind(@),3000
      console.log "Win! Player"
    else if stand
      if @playerScore()[0] <= @dealerScore()[0]
        @win("dealer")
        setTimeout @resetDeck.bind(@),3000
        console.log "Win! dealer - player score less than dealer"
      else
        @win("player")
        setTimeout @resetDeck.bind(@),3000
        console.log "Win! Player - player score greater than dealer"
    else 
      console.log "Keep playing, win not detected"
      return


  resetDeck:()->
    @set 'deck', deck = new Deck();
    @set 'playerHand', deck.dealPlayer();
    @set 'dealerHand', deck.dealDealer();
    @listenTo (@get "dealerHand"),"checkWin",@checkWin
    @listenTo (@get "playerHand"),"checkWin",@checkWin
    return @trigger('winDetected')

