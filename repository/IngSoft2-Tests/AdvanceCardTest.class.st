Class {
	#name : 'AdvanceCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
AdvanceCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: error messageText equals: errorMessage ].
]

{ #category : 'tests' }
AdvanceCardTest >> testApplyEffectMovesShipForward [
    | card ship board dice game |
    card := AdvanceCard new.
    ship := Spaceship withName: 'Explorer'.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game
        startWithShips: { ship. (Spaceship withName: 'Other') }
        board: board
        dice: dice
        laps: 1.
    board moveShip: ship to: 2.
    card applyEffectTo: ship inGame: game.
    self assert: ship position equals: 3.
]

{ #category : 'tests' }
AdvanceCardTest >> testPlayOnMovesShipForwardWhenInProgress [
    | card ship board dice game |
    card := AdvanceCard new.
    ship := Spaceship withName: 'Racer'.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game
        startWithShips: { ship. (Spaceship withName: 'Opponent') }
        board: board
        dice: dice
        laps: 1.
    board moveShip: ship to: 1.
    card playOn: ship inGame: game.
    self assert: ship position equals: 2.
]
