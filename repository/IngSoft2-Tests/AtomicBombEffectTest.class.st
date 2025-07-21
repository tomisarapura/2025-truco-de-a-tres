Class {
	#name : 'AtomicBombEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombEffectTest >> testApplyEffectToWithMultipleShips [


	| ship1 ship2 ship3 board effect |
	ship1 := Spaceship withName: 'Ship1'.
	ship2 := Spaceship withName: 'Ship2'.
	ship3 := Spaceship withName: 'Ship3'.

	ship1 moveTo: 5.
	ship2 moveTo: 15.
	ship3 moveTo: 25.

	board := Board of: 30 andWormholeAt: #(  ).
	board registerShips: {
			ship1.
			ship2.
			ship3 }.

	effect := AtomicBombEffect new.
	effect applyEffectTo: ship2 inBoard: board.

	self assert: ship1 position equals: 0.
	self assert: ship2 position equals: 0.
	self assert: ship3 position equals: 0
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

    | ship1 ship2 effect board |

    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.

    ship1 moveTo: 5.
    ship2 moveTo: 9.

    effect := AtomicBombEffect new.
    board := Board of: 1 andWormholeAt: {}.
    board registerShips: { ship1. ship2 }.
    effect applyTo: ship1 inContextOf: { ship1. ship2 } inBoard: board.

    self assert: ship1 position equals: 0.
    self assert: ship2 position equals: 0.
]

{ #category : 'tests' }
AtomicBombEffectTest >> testApplyToInContextWithNullBoard [

	| ship1 ship2 effect |
	ship1 := Spaceship withName: 'One'.
	ship2 := Spaceship withName: 'Two'.

	ship1 moveTo: 5.
	ship2 moveTo: 9.

	effect := AtomicBombEffect new.
	effect
		applyTo: ship1
		inContextOf: {
				ship1.
				ship2 }
		inBoard: nil.

	self assert: ship1 position equals: 0.
	self assert: ship2 position equals: 0
]
