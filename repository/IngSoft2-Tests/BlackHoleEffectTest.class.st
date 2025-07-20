Class {
	#name : 'BlackHoleEffectTest',
	#superclass : 'TestCase',
	#instVars : [
		'ship1',
		'ship2',
		'board',
		'dice',
		'game'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleEffectTest >> setUp [

	ship1 := Spaceship withName: 'John Doe'.
	ship2 := Spaceship withName: 'Jane Doe'.
	board := Board of: 5 andWormholeAt: {  }.
	dice := DiceCup with: { (Die withSides: 1) }.
	game := Game
		        startWithShips: {
				        ship1.
				        ship2 }
		        board: board
		        dice: dice
		        laps: 1
]

{ #category : 'tests' }
BlackHoleEffectTest >> testApplyEffectDecreasesTurbine [

	| effect |
	board moveShip: ship1 to: 6.

	effect := BlackHoleEffect new.

	self assert: ship1 remainingTurbines equals: 3.

	effect applyTo: ship1 inBoard: board.

	self assert: ship1 position equals: 2.
	self assert: ship1 remainingTurbines equals: 2
]

{ #category : 'tests' }
BlackHoleEffectTest >> testApplyToDoesNotGoBelowZero [

	| effect |
	board moveShip: ship1 to: 3.
	effect := BlackHoleEffect new.
	effect applyTo: ship1 inBoard: board.

	self assert: ship1 position equals: 0
]

{ #category : 'tests' }
BlackHoleEffectTest >> testApplyToMovesShipBackBy4 [

	| effect |
	board moveShip: ship1 to: 6.
	ship1 moveTo: 6.

	effect := BlackHoleEffect new.
	effect applyTo: ship1 inBoard: board.

	self assert: ship1 position equals: 2
]
