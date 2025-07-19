Class {
	#name : 'AtomicBombEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombEffectTest >> testApplyEffectMultipleTimesHasNoAdditionalImpact [

	| effect board ship |
	effect := AtomicBombEffect new.
	board := Board of: 2 andWormholeAt: #(  ).
	ship := Spaceship withName: 'Ship'.
	board registerShips: { ship }.

	board moveShip: ship to: 3.
	effect applyEffectTo: ship inBoard: board.
	effect applyEffectTo: ship inBoard: board.

	self assert: (board positionOf: ship) equals: 0
]

{ #category : 'tests' }
AtomicBombEffectTest >> testApplyEffectToMovesAllShipsToZero [

	| effect board ship1 ship2 ship3 ships |
	effect := AtomicBombEffect new.
	board := Board of: 3 andWormholeAt: #(  ).

	ship1 := Spaceship withName: 'Ship1'.
	ship2 := Spaceship withName: 'Ship2'.
	ship3 := Spaceship withName: 'Ship3'.
	ships := {
		         ship1.
		         ship2.
		         ship3 }.
	board registerShips: ships.

	board moveShip: ship1 to: 5.
	board moveShip: ship2 to: 7.
	board moveShip: ship3 to: 2.

	effect applyEffectTo: ship1 inBoard: board.

	self assert: (board positionOf: ship1) equals: 0.
	self assert: (board positionOf: ship2) equals: 0.
	self assert: (board positionOf: ship3) equals: 0
]

{ #category : 'tests' }
AtomicBombEffectTest >> testApplyEffectToOnEmptyBoardDoesNotError [

	| effect board |
	effect := AtomicBombEffect new.
	board := Board of: 1 andWormholeAt: #(  ).

	effect applyEffectTo: nil inBoard: board.

	self assert:
		(board shipsOnBoard isNil or: [ board shipsOnBoard isEmpty ])
]

{ #category : 'tests' }
AtomicBombEffectTest >> testApplyToDoesNothing [

    | ship effect |

    ship := Spaceship withName: 'Solo'.
    ship moveTo: 5.

    effect := AtomicBombEffect new.
    effect applyTo: ship.

    self assert: ship position equals: 5.
]

{ #category : 'tests' }
AtomicBombEffectTest >> testApplyToInContextResetsAllPositions [

	| ship1 ship2 allShips effect board game |
	ship1 := Spaceship withName: 'One'.
	ship2 := Spaceship withName: 'Two'.
	allShips := {
		            ship1.
		            ship2 }.

	ship1 moveTo: 5.
	ship2 moveTo: 9.

	effect := AtomicBombEffect new.
	board := Board of: 1 andWormholeAt: {  }.

	game := Game
		        startWithShips: allShips
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	effect applyEffectTo: ship1 inBoard: board.

	self assert: ship1 position equals: 0.
	self assert: ship2 position equals: 0
]
