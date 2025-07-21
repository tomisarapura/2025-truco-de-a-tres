Class {
	#name : 'CardEffect',
	#superclass : 'EffectDecorator',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
CardEffect >> applyEffectTo: aSpaceship inBoard: aBoard [

	aSpaceship addCard: aBoard drawCard
]

{ #category : 'operations' }
CardEffect >> applyInvertedTo: aSpaceship inBoard: aBoard [

	aBoard shipsOnBoard do: [ :ship |
		ship == aSpaceship ifFalse: [
			self applyEffectTo: ship inBoard: aBoard ] ].
	^ self
]
