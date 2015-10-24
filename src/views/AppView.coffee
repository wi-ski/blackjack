class window.AppView extends Backbone.View

  el: '.game'

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <span>Dealer Score: <%= dealer %></span>
    <span>Player: <%= player %></span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').stand()

  initialize: ->
    @render()
    @model.listenTo @model, 'winDetected', @render
    console.log "THIS BE THIS: ",@

  render: ->
    @el = $('.game')
    console.log "THIS BE $EL: ", @$el.children()
    console.log "THIS BE EL: ", @el
    @$el.children().detach()
    @$el.html @template({player: @model.get("playerWins"),dealer:@model.get("dealerWins")})
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

