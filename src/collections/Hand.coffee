class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->



  hit: ->
    @add(@deck.pop())
    @trigger('checkWin')
    # @maxScore()
    @last() 

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  # maxScore: ->
  #   # if the second score exists, then check if both are less than 21
  #   if @hasAce()
  #     otherCard = @scores()[0]
  #     @scores()[1]
  #   else
  #     @scores()[0]
  #   # if both are less than 21, return the max of the two
  #   # else, return the one that is less than 21

  stand: ->
    console.log "STAND TRIGGED", this
    if !@isDealer
      console.error "Please check hand assignments..."
    else
      console.log("THIS BE LAST: ",@first())
      @first().flip()
      @trigger('checkWin')
  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), (@minScore() + 10 * @hasAce())-1]


