Class {
	#name : 'MoonWalkEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonWalkEffectTest >> testApplyToDoesNothing [

	| effect ship1 ship2 allShips originalPosition board game |
	effect := MoonWalkEffect new.
	ship1 := Spaceship withName: 'Ship1'.
	ship2 := Spaceship withName: 'Ship2'.
	allShips := {
		            ship1.
		            ship2 }.

	board := Board of: 10 andWormholeAt: {  }.

	game := Game
		        startWithShips: allShips
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	originalPosition := ship1 position.
	effect applyEffectTo: ship1 inBoard: board.

	self assert: ship1 position equals: originalPosition
]

{ #category : 'tests' }
MoonWalkEffectTest >> testApplyToInContextMovesOthersBack [

	| effect ship1 ship2 ship3 allShips game board |
	effect := MoonWalkEffect new.

	ship1 := Spaceship withName: 'TargetShip'.
	ship2 := Spaceship withName: 'Ship2'.
	ship3 := Spaceship withName: 'Ship3'.

	ship1 moveTo: 5.
	ship2 moveTo: 5.
	ship3 moveTo: 5.

	allShips := {
		            ship1.
		            ship2.
		            ship3 }.
	board := Board of: 10 andWormholeAt: {  }.

	game := Game
		        startWithShips: allShips
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.


	effect applyEffectTo: ship1 inBoard: board.

	self assert: ship1 position equals: 5.
	self assert: ship2 position equals: 3.
	self assert: ship3 position equals: 3
]
