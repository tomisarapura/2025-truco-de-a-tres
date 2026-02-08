Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#instVars : [
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CancellationCard class >> cancelling: aCard [
	^ self new initializeCancelling: aCard
]

{ #category : 'playing' }
CancellationCard >> applyEffectTo: aShip inGame: aGame [

	(aGame activeCards includes: cardToCancel) ifFalse: [
		self error: 'Cannot cancel a card that is not active in the game' ].

	aGame removeActiveCard: cardToCancel
]

{ #category : 'initialization' }
CancellationCard >> initializeCancelling: aCard [

	cardToCancel := aCard.
	^ self
]
