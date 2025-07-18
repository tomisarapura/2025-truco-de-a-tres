Class {
	#name : 'BlackHoleEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleEffectTest >> testApplyEffectDecreasesTurbine [

	| ship effect |
	ship := Spaceship withName: 'John Doe'.
	ship moveTo: 6.
	effect := BlackHoleEffect new.

	self assert: ship remainingTurbines equals: 3.

	effect applyTo: ship.

	self assert: ship position equals: 2.
	self assert: ship remainingTurbines equals: 2
]

{ #category : 'tests' }
BlackHoleEffectTest >> testApplyToDoesNotGoBelowZero [

    | ship effect |

    ship := Spaceship withName: 'Boundary'.
    ship moveTo: 3.

    effect := BlackHoleEffect new.
    effect applyTo: ship.

    self assert: ship position equals: 0.
]

{ #category : 'tests' }
BlackHoleEffectTest >> testApplyToMovesShipBackBy4 [

    | ship effect |

    ship := Spaceship withName: 'Voyager'.
    ship moveTo: 6.

    effect := BlackHoleEffect new.
    effect applyTo: ship.

    self assert: ship position equals: 2.
]
