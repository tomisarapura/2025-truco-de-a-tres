Class {
	#name : 'EffectDecoratorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectDecoratorTest >> testApplyInvertedTo [

	| decorator ship |
	decorator := EffectDecorator new.
	ship := Spaceship withName: 'TestShip'.
	ship moveTo: 7.

	decorator applyInvertedTo: ship inBoard: NullBoard new.

	self assert: ship position equals: 7
]

{ #category : 'tests' }
EffectDecoratorTest >> testApplyToWithBoard [

	| decorator ship board originalPosition |
	decorator := EffectDecorator new.
	ship := Spaceship withName: 'Ship'.
	board := NullBoard new.
	ship moveTo: 5.
	originalPosition := ship position.

	decorator applyTo: ship inBoard: board.

	self assert: ship position equals: originalPosition
]

{ #category : 'tests' }
EffectDecoratorTest >> testApplyToWithWrappedEffectAndBoard [

	| decorator ship wrappedEffect board |
	wrappedEffect := MoonWalkEffect new.
	decorator := EffectDecorator new decorate: wrappedEffect.

	ship := Spaceship withName: 'MainShip'.
	board := NullBoard new.
	ship moveTo: 5.

	decorator applyTo: ship inBoard: board.

	"La posición no debería cambiar"
	self assert: ship position equals: 5
]

{ #category : 'tests' }
EffectDecoratorTest >> testApplyToWithoutWrappedEffectDoesNothing [

    | decorator ship originalPosition |

    decorator := EffectDecorator new.

    ship := Spaceship withName: 'SoloShip'.
    ship moveTo: 3.

    originalPosition := ship position.

    decorator applyTo: ship.

    self assert: ship position equals: originalPosition.
]

{ #category : 'tests' }
EffectDecoratorTest >> testEffectDecoratorDecorateSetsWrappedEffect [
	| baseEffect decorator |
	baseEffect := NoEffect new.
	decorator := EffectDecorator new decorate: baseEffect.

	self assert: decorator wrapped equals: baseEffect.
]
