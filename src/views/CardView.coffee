class window.CardView extends Backbone.View
  # className: 'card'
  # el:'.card'
  # template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<span class="card <%= suitName %>">
                          <span class="rank">
                            <%= rankName %>
                          </span>
                          <span class="suit">
                          </span>
                        </span>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

