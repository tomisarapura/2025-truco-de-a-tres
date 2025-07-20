Class {
	#name : 'HyperGravityEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperGravityEffectTest >> testAllowsEntryWithRollFalseWhenLow [

    | effect |

    effect := HyperGravityEffect new.
    effect requiredRoll: 6.

    self deny: (effect allowsEntryWithRoll: 5).
]

{ #category : 'tests' }
HyperGravityEffectTest >> testAllowsEntryWithRollTrueWhenEnough [

    | effect |

    effect := HyperGravityEffect new.
    effect requiredRoll: 3.

    self assert: (effect allowsEntryWithRoll: 5).
    self assert: (effect allowsEntryWithRoll: 3).
]

{ #category : 'tests' }
HyperGravityEffectTest >> testApplyToMoveShipBackwardsOneStep [

	| ship1 ship2 board dice game effect |
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
		        laps: 1.
	board moveShip: ship1 to: 5.

	effect := HyperGravityEffect new.
	effect applyTo: ship1 inBoard: board.

	self assert: ship1 position equals: 4
]

{ #category : 'tests' }
HyperGravityEffectTest >> testShipLosesTurbineWhenFailingToEscapeHyperGravity [

	| ship1 ship2 players effect board game |
	ship1 := Spaceship withName: 'John Doe'.
	ship2 := Spaceship withName: 'Jane Doe'.
	players := OrderedCollection new.
	players add: ship1.
	players add: ship2.
	effect := HyperGravityEffect new.
	board := Board of: 10 andWormholeAt: {  }.
	game := Game
		        startWithShips: players
		        board: board
		        dice: (DiceCup with: { (Die withSides: 6) })
		        laps: 1.

	effect requiredRoll: 5.

	(effect allowsEntryWithRoll: 3) ifFalse: [
		effect applyEffectTo: ship1 inBoard: board ].

	self assert: ship1 remainingTurbines equals: 2
]
