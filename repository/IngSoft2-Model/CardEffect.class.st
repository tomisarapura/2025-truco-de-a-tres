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

	aBoard doOnAllShipsExcept: aSpaceship do: [ :otherShip |
        self applyEffectTo: otherShip inBoard: aBoard ].
    ^ self
]
