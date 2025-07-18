Class {
	#name : 'BlackHoleEffect',
	#superclass : 'EffectDecorator',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
BlackHoleEffect >> applyEffectTo: aSpaceship inBoard: aBoard [

	| board |
	aSpaceship decreaseTurbine.
	board := aBoard ifNil: [ NullBoard new ] ifNotNil: [ aBoard ].
	board moveShip: aSpaceship backward: 4
]

{ #category : 'operations' }
BlackHoleEffect >> applyInvertedTo: aSpaceship inBoard: aBoard [

	aBoard shipsOnBoard do: [ :ship |
		ship == aSpaceship ifFalse: [
			self applyEffectTo: ship inBoard: aBoard ] ].
	^ self
]
