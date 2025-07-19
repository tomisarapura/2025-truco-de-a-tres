Class {
	#name : 'AtomicBombEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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
