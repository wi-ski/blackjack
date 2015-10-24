class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->



  hit: ->
    @add(@deck.pop())
    @trigger('checkWin')  
    @last() 

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  stand: ->
    console.log "STAND TRIGGED", this
    if !@isDealer
      console.error "Please check hand assignments..."
    else
      @first().flip()
      @trigger('checkWin', true)



  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), (if @hasAce() then @minScore()+10 else @minScore())]
    # [@minScore(), (@minScore() + 11 * @hasAce())-1]


