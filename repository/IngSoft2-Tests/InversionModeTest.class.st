Class {
	#name : 'InversionModeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
InversionModeTest >> testInvertedInversionModeInvertsEffect [

	| mode effect ship otherShip board |
	mode := InvertedInversionMode new.
	ship := Spaceship withName: 'Main'.
	otherShip := Spaceship withName: 'Other'.
	board := Board of: 10 andWormholeAt: #(  ).
	board registerShips: {
			ship.
			otherShip }.
	board moveShip: ship to: 5.
	board moveShip: otherShip to: 8.

	effect := HyperGravityEffect new.
	mode applyEffect: effect to: ship inBoard: board.

	self assert: (board positionOf: ship) equals: 5.
	self assert: (board positionOf: otherShip) equals: 7
]

{ #category : 'tests' }
InversionModeTest >> testInvertedInversionModeWormholeTransportsOthers [

	| game board wormhole ship1 ship2 reverseCard |
	wormhole := Wormhole from: 5 to: 8.
	board := Board of: 10 andWormholeAt: { wormhole }.

	ship1 := Spaceship withName: 'Ship1'.
	ship2 := Spaceship withName: 'Ship2'.

	game := Game
		        startWithShips: (OrderedCollection with: ship1 with: ship2)
		        board: board
		        dice: (DiceCup with: { (Die withSides: 6) })
		        laps: 3.

	reverseCard := ReversePolarityCard forCell: 5.
	ship1 addCard: reverseCard.

	ship1 playCard: reverseCard inGame: game.

	board moveShip: ship2 to: 5.

	self assert: (board positionOf: ship1) equals: 8.
	self assert: (board positionOf: ship2) equals: 5
]

{ #category : 'tests' }
InversionModeTest >> testNormalInversionModeAppliesEffectDirectly [

	| mode effect ship board |
	mode := NormalInversionMode new.
	effect := HyperGravityEffect new.
	ship := Spaceship withName: 'Test'.
	board := Board of: 10 andWormholeAt: #(  ).
	board registerShips: { ship }.
	board moveShip: ship to: 5.

	effect := HyperGravityEffect new.
	mode applyEffect: effect to: ship inBoard: board.
	self assert: (board positionOf: ship) equals: 4
]

{ #category : 'tests' }
InversionModeTest >> testNormalInversionModeWormholeTransportsShip [

	| mode wormhole ship board exitPosition |
	mode := NormalInversionMode new.
	wormhole := Wormhole from: 5 to: 8.
	ship := Spaceship withName: 'Test'.
	board := Board of: 10 andWormholeAt: { wormhole }.
	board registerShips: { ship }.
	board moveShip: ship to: 5.

	exitPosition := mode
		                applyWormholeEffect: wormhole
		                at: 5
		                inBoard: board.
	self assert: exitPosition equals: 8
]
