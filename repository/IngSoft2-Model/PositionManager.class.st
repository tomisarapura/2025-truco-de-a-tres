Class {
	#name : 'PositionManager',
	#superclass : 'Object',
	#instVars : [
		'positions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
PositionManager class >> forShips: someShips [

	self validateShips: someShips.

	^ self new initializeForShips: someShips
]

{ #category : 'initialization' }
PositionManager class >> validateShips: someShips [

	(someShips isCollection and: [
		 someShips notEmpty and: [
			 someShips allSatisfy: [ :each | each isKindOf: Spaceship ] ] ])
		ifFalse: [
			self error:
				'Ships must be a non-empty collection of Spaceship instances' ]
]

{ #category : 'initialization' }
PositionManager >> initializeForShips: someShips [

	positions := Dictionary new.
	someShips do: [ :ship | positions at: ship put: ship position ].
	^ self
]

{ #category : 'updating' }
PositionManager >> moveShip: aShip backward: steps [

	| newPos |
	newPos := (self positionOf: aShip) - steps max: 0.
	self moveShip: aShip to: newPos
]

{ #category : 'updating' }
PositionManager >> moveShip: aShip forward: steps [

	self moveShip: aShip to: (self positionOf: aShip) + steps
]

{ #category : 'updating' }
PositionManager >> moveShip: aShip to: aPosition [

	| validPosition |
	validPosition := aPosition max: 0.
	positions at: aShip put: validPosition.
	aShip moveTo: validPosition
]

{ #category : 'accessing' }
PositionManager >> positionOf: aShip [

	^ positions at: aShip
]

{ #category : 'accessing' }
PositionManager >> positions [

	^ positions
]
