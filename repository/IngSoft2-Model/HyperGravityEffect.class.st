Class {
	#name : 'HyperGravityEffect',
	#superclass : 'EffectDecorator',
	#instVars : [
		'requiredRoll'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperGravityEffect >> allowsEntryWithRoll: aNumber [
	^ aNumber >= requiredRoll
]

{ #category : 'operations' }
HyperGravityEffect >> applyEffectTo: aSpaceship inBoard: aBoard [

	aSpaceship decreaseTurbine.
	aBoard
		ifNil: [ aSpaceship moveBack: 1 ]
		ifNotNil: [ aBoard moveShip: aSpaceship backward: 1 ].
	^ aSpaceship
]

{ #category : 'initialization' }
HyperGravityEffect >> applyInvertedTo: aSpaceship inBoard: aBoard [

	aBoard shipsOnBoard do: [ :ship |
		ship == aSpaceship ifFalse: [
			self applyEffectTo: ship inBoard: aBoard ] ].
	^ self
]

{ #category : 'initialization' }
HyperGravityEffect >> initialize [
	super initialize.
	requiredRoll := 4.
]

{ #category : 'initialization' }
HyperGravityEffect >> requiredRoll [
	^ requiredRoll

]

{ #category : 'initialization' }
HyperGravityEffect >> requiredRoll: aNumber [
	requiredRoll := aNumber.

]
