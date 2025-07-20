Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'playerName',
		'maxFuel',
		'fuel',
		'lap',
		'cards',
		'activeCards',
		'state',
		'turbines'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Spaceship class >> validatingName: aName [
	
	aName isEmpty ifTrue: [ self error: 'A name cannot be empty' ].
]

{ #category : 'initialize' }
Spaceship class >> withName: aName [

	self validatingName: aName.
	^ self new initializeWith: aName
]

{ #category : 'methods' }
Spaceship >> activeCards [
	^ activeCards
]

{ #category : 'methods' }
Spaceship >> addActiveCard: aCard [
	activeCards add: aCard.
]

{ #category : 'methods' }
Spaceship >> addCard: aCard [
	cards add: aCard.
]

{ #category : 'methods' }
Spaceship >> cards [
	^ cards
]

{ #category : 'fuel' }
Spaceship >> decreaseFuelBy: anAmount [

	| newFuel |
	newFuel := fuel - anAmount.
	newFuel <= 0
		ifTrue: [
			self decreaseTurbine.
			fuel := maxFuel ]
		ifFalse: [ fuel := newFuel ]
]

{ #category : 'methods' }
Spaceship >> decreaseTurbine [

	self hasAvailableTurbines ifFalse: [
		self error: 'There are no turbines available' ].

	turbines := turbines - 1
]

{ #category : 'methods' }
Spaceship >> hasAvailableTurbines [

	^ turbines > 0
]

{ #category : 'initialize' }
Spaceship >> hasReachedGoalOn: aBoard [

    ^ aBoard isPositionReachedAt: position.

]

{ #category : 'fuel' }
Spaceship >> increaseFuelBy: someFuel [

	fuel := fuel + someFuel
]

{ #category : 'fuel' }
Spaceship >> increaseMaxFuelBy: anAmount [
    maxFuel := maxFuel + anAmount.
]

{ #category : 'initialize' }
Spaceship >> initializeWith: aName [

	playerName := aName.
	position := 0.
	fuel := 0.
	maxFuel := 0.
	lap := 0.
	cards := OrderedCollection new.
	activeCards := OrderedCollection new.
	state := NormalShipState new.
	turbines := 3
]

{ #category : 'state' }
Spaceship >> isPenalized [

	^ state isPenalized

]

{ #category : 'initialize' }
Spaceship >> lap [

	^ lap
]

{ #category : 'move' }
Spaceship >> moveBack: steps [

	position := position - steps max: 0
]

{ #category : 'move' }
Spaceship >> moveForward: steps [

	position := position + steps max: 0
]

{ #category : 'move' }
Spaceship >> moveTo: aPosition [

    position := aPosition max: 0.

]

{ #category : 'accessing' }
Spaceship >> name [

	^ playerName
]

{ #category : 'state' }
Spaceship >> penalizeFor: aNumber [

	state := state penalizeFor: aNumber
]

{ #category : 'state' }
Spaceship >> penaltyTurnsRemaining [

	^ state turnsRemaining
]

{ #category : 'cards' }
Spaceship >> playCard: aCard inGame: aGame [

	aGame ensureGameIsNotOver.
	(cards includes: aCard) ifFalse: [ self error: 'Card not in hand' ].
	aCard playOn: self inGame: aGame.
	self removeCard: aCard.
	aGame lastCardPlayed: aCard
]

{ #category : 'initialize' }
Spaceship >> position [

    ^ position.
]

{ #category : 'state' }
Spaceship >> reducePenalty [

	state := state reducePenalty

]

{ #category : 'accessing' }
Spaceship >> remainingTurbines [

	^ turbines
]

{ #category : 'cards' }
Spaceship >> removeCard: aCard [

	cards remove: aCard ifAbsent: [  ]
]

{ #category : 'methods' }
Spaceship >> restoreFuel [

        fuel := maxFuel.
]

{ #category : 'state' }
Spaceship >> state [

	^ state
]

{ #category : 'state' }
Spaceship >> state: aState [

	state := aState
]
