assert = chai.assert

describe 'Hand', ->
  beforeEach ->
    window.deck = new Deck()
    window.phand = deck.dealPlayer()
    window.dhand = deck.dealDealer()
    return
     
  describe 'dealerHand', ->
    it 'should have "is dealer" prop set to true', ()->
      assert.strictEqual dhand.isDealer, true

    it 'should flip the last card in the dealer\'s hand', ->
      assert.strictEqual dhand.last().get("revealed"), true
      assert.strictEqual dhand.first().get("revealed"), false

  # describe ''

  # hit > puts last card in the deck in the hand, triggers checkwin
  # stand >  flips first if dealer, triggers checkWin
  