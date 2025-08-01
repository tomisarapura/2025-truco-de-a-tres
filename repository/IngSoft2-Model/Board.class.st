Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'cellCount',
		'wormholes',
		'cells',
		'totalLengthInParsecs',
		'positionManager',
		'shipsOnBoard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Board class >> convertToParsecs: aLength [
    ^ (aLength isKindOf: Distance)
        ifTrue: [ aLength asParsecs ]
        ifFalse: [ aLength ].
]

{ #category : 'initialize' }
Board class >> of: anAmountOfCells andWormholeAt: positions [

	self validateCellCount: anAmountOfCells.
	self validateWormholes: positions.
	^ self new
		  initializeWithCells: anAmountOfCells
		  andWormholes: positions
]

{ #category : 'initialize' }
Board class >> of: anAmountOfCells length: parsecLength andWormholeAt: positions [

	| lengthOnParsecs |
	self validateCellCount: anAmountOfCells.
	self validateWormholes: positions.
	lengthOnParsecs := self convertToParsecs: parsecLength.

	^ self new
		  initializeWithCells: anAmountOfCells
		  length: lengthOnParsecs
		  andWormholes: positions
]

{ #category : 'initialize' }
Board class >> of: anAmountOfCells length: parsecLength lengthLightYears: lightYears andWormholeAt: positions [

	self
		validateLengthConsistencyBetweenParsecs: parsecLength
		andLightYears: lightYears.
	self validateCellCount: anAmountOfCells.
	self validateWormholes: positions.

	parsecLength
		ifNil: [
			^ self
				  of: anAmountOfCells
				  lengthLightYears: lightYears
				  andWormholeAt: positions ]
		ifNotNil: [
			^ self
				  of: anAmountOfCells
				  length: parsecLength
				  andWormholeAt: positions ]
]

{ #category : 'initialize' }
Board class >> of: anAmountOfCells lengthLightYears: lightYears andWormholeAt: positions [

	self validateCellCount: anAmountOfCells.
	self validateWormholes: positions.

	^ self
		  of: anAmountOfCells
		  length: (Distance lightYears: lightYears) asParsecs
		  andWormholeAt: positions
]

{ #category : 'initialize' }
Board class >> validateCellCount: aCount [

	(aCount isInteger and: [ aCount > 0 ]) ifFalse: [
		self error: 'Board must have a positive number of cells' ]
]

{ #category : 'initialize' }
Board class >> validateLengthConsistencyBetweenParsecs: parsecLength andLightYears: lightYears [
    (parsecLength notNil and: [ lightYears notNil ]) ifTrue: [
        (Distance parsecs: parsecLength) asLightYears = lightYears ifFalse: [
            self error: 'Length mismatch between parsecs and light years'
        ]
    ]
]

{ #category : 'initialize' }
Board class >> validateWormholes: aCollection [

	(aCollection isCollection and: [
		 aCollection allSatisfy: [ :each | each isValid ] ]) ifFalse: [
		self error: 'All wormholes must be valid objects' ]
]

{ #category : 'method' }
Board >> activeCardsOnCell: aCell [

	^ self reversePolarityCards select: [ :card |
		  card targetCell = aCell ]
]

{ #category : 'method' }
Board >> allActiveCards [

	| cards |
	cards := OrderedCollection new.
	shipsOnBoard do: [ :ship | cards addAll: ship activeCards ].
	^ cards
]

{ #category : 'method' }
Board >> applyEffect: anEffect to: aSpaceship inverted: aBoolean [

	aBoolean
		ifTrue: [ anEffect applyInvertedTo: aSpaceship inBoard: self ]
		ifFalse: [ anEffect applyTo: aSpaceship inBoard: self ]
]

{ #category : 'method' }
Board >> applyEffectTo: aSpaceship [

	| cellPosition effect |
	cellPosition := self positionOf: aSpaceship.
	effect := self effectAt: cellPosition.

	effect ifNotNil: [
		| shouldInvert |
		shouldInvert := self isCellInverted: cellPosition.
		self applyEffect: effect to: aSpaceship inverted: shouldInvert ].

	^ self
]

{ #category : 'method' }
Board >> applyWormholeEffect: aWormhole at: aPosition [

	(self isCellInverted: aPosition)
		ifTrue: [
			self shipsOnBoard do: [ :ship |
				ship position = aPosition ifFalse: [
					self moveShip: ship to: aWormhole exit ] ].
			^ aPosition ]
		ifFalse: [ ^ aWormhole exit ]
]

{ #category : 'method' }
Board >> applyWormholeIfPresentAt: aPosition [

	| wormhole |
	wormhole := self wormholeAt: aPosition.

	wormhole ifNil: [ ^ aPosition ].

	^ self applyWormholeEffect: wormhole at: aPosition
]

{ #category : 'testing' }
Board >> assignEffect: anEffect toCell: aCellPosition [

	cells at: aCellPosition put: anEffect
]

{ #category : 'moves' }
Board >> calculateNewPositionFrom: current after: steps moves: aShipStatus [

	| newPosition |
	
	newPosition := (current + steps) \\ cellCount.

	(newPosition <= current) ifTrue: [ aShipStatus addLap ].

	^ newPosition.
]

{ #category : 'accessing' }
Board >> cellCount [
    ^ cells size.
]

{ #category : 'accessing' }
Board >> cells [
	^ cells.

]

{ #category : 'moves' }
Board >> determineNewPositionFrom: aPosition after: steps [

	^ self applyWormholeIfPresentAt: aPosition + steps
]

{ #category : 'deck' }
Board >> drawCard [

	^ CardDeck randomCard
]

{ #category : 'method' }
Board >> effectAt: aPosition [

	^ cells at: aPosition ifAbsent: [ NoEffect new ]
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount andWormholes: aCollection [
    ^ self
        initializeWithCells: aCount
        length: aCount
        andWormholes: aCollection
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount length: aLengthInParsecs andWormholes: aCollection [
    cellCount := aCount.
    totalLengthInParsecs := aLengthInParsecs.
    wormholes := aCollection.
         cells := Dictionary new.

        0 to: aCount - 1 do: [ :i |
                cells at: i put: self randomEffect ].

    ^ self
]

{ #category : 'method' }
Board >> isCellInverted: aCell [

    ^ (self activeCardsOnCell: aCell) size odd
]

{ #category : 'validation' }
Board >> isPositionReachedAt: aPosition [

    ^ aPosition >= cellCount.
]

{ #category : 'spaceships' }
Board >> moveShip: aShip backward: steps [

	positionManager ifNil: [ self error: 'Board has no registered ships' ].
	positionManager moveShip: aShip backward: steps
]

{ #category : 'spaceships' }
Board >> moveShip: aShip forward: steps [

	positionManager ifNil: [ self error: 'Board has no registered ships' ].
	positionManager moveShip: aShip forward: steps
]

{ #category : 'spaceships' }
Board >> moveShip: aShip to: aPosition [

	| finalPosition |
	positionManager ifNil: [ self error: 'Board has no registered ships' ].
	
	finalPosition := self applyWormholeIfPresentAt: aPosition.

	positionManager moveShip: aShip to: finalPosition
]

{ #category : 'spaceships' }
Board >> positionOf: aShip [

	positionManager ifNil: [ self error: 'Board has no registered ships' ].
	^ positionManager positionOf: aShip
]

{ #category : 'initialize' }
Board >> randomEffect [

	| randomNumber |
	randomNumber := (1 to: 100) atRandom.
	randomNumber <= 10 ifTrue: [ ^ CardEffect new ].
	randomNumber <= 48 ifTrue: [ ^ NoEffect new ].
	randomNumber <= 74 ifTrue: [ ^ BlackHoleEffect new ].
	^ HyperGravityEffect new

]

{ #category : 'spaceships' }
Board >> registerShips: someShips [

	shipsOnBoard := someShips copy.

	positionManager := PositionManager forShips: someShips
]

{ #category : 'method' }
Board >> reversePolarityCards [

	^ self allActiveCards select: [ :card |
		  card isKindOf: ReversePolarityCard ]
]

{ #category : 'accessing' }
Board >> shipsOnBoard [

	^ shipsOnBoard
]

{ #category : 'steps' }
Board >> stepsFromDistance: aDistance [

    ^ self stepsFromParsecs: aDistance asParsecs
]

{ #category : 'steps' }
Board >> stepsFromLightYears: someLightYears [

	^ self stepsFromParsecs:
		  (Distance lightYears: someLightYears) asParsecs
]

{ #category : 'steps' }
Board >> stepsFromParsecs: someParsecs [

	| ratio |
	ratio := someParsecs / totalLengthInParsecs.
	^ (ratio * cellCount) rounded
]

{ #category : 'accessing' }
Board >> totalLengthInParsecs [
    ^ totalLengthInParsecs
]

{ #category : 'method' }
Board >> wormholeAt: aPosition [

	^ wormholes detect: [ :w | w hasEntryAt: aPosition ] ifNone: [ nil ]
]
