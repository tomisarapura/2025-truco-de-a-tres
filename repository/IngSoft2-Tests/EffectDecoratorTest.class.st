Class {
	#name : 'EffectDecoratorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectDecoratorTest >> testApplyToWithoutWrappedEffectDoesNothing [

	| decorator ship1 ship2 board dice game originalPosition |
	decorator := EffectDecorator new.


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
	board moveShip: ship1 to: 3.

	originalPosition := ship1 position.

	decorator applyTo: ship1 inBoard: board.

	self assert: ship1 position equals: originalPosition
]

{ #category : 'tests' }
EffectDecoratorTest >> testEffectDecoratorDecorateSetsWrappedEffect [

	| baseEffect decorator |
	baseEffect := NoEffect new.
	decorator := EffectDecorator new decorate: baseEffect.

	self assert: decorator wrapped equals: baseEffect
]
