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
    @listenTo @model, 'winDetected', @render

  render: ->
    @$el.children().detach()
    @$el.html @template({player: @model.get("playerWins"),dealer:@model.get("dealerWins")})
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

