Class {
	#name : 'PositionManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - class' }
PositionManagerTest >> testForShipsInitializesPositions [
    | ship1 ship2 manager |
    ship1 := Spaceship withName: 'Alpha'.
    ship2 := Spaceship withName: 'Beta'.
    ship1 moveTo: 5.
    ship2 moveTo: 7.
    manager := PositionManager forShips: { ship1 . ship2 }.
    self assert: (manager positionOf: ship1) equals: 5.
    self assert: (manager positionOf: ship2) equals: 7.
]

{ #category : 'tests' }
PositionManagerTest >> testForShipsValidatesInput [

	| invalidInput |
	invalidInput := 'not a collection of ships'.
	self should: [ PositionManager forShips: invalidInput ] raise: Error.

	invalidInput := { 'not a ship'. 42 }.
	self should: [ PositionManager forShips: invalidInput ] raise: Error.

	invalidInput := OrderedCollection new.
	self should: [ PositionManager forShips: invalidInput ] raise: Error
]

{ #category : 'tests - instance' }
PositionManagerTest >> testInitializeForShipsReturnsSelf [

	| ship1 ship2 manager result |
	ship1 := Spaceship withName: 'Alpha'.
	ship2 := Spaceship withName: 'Beta'.
	ship1 moveTo: 3.
	ship2 moveTo: 8.
	manager := PositionManager new.
	result := manager initializeForShips: {
			          ship1.
			          ship2 }.
	self assert: result equals: manager.
	self assert: (manager positionOf: ship1) equals: 3.
	self assert: (manager positionOf: ship2) equals: 8
]

{ #category : 'tests - instance' }
PositionManagerTest >> testMoveShipBackwardDoesNotGoBelowZero [
    | ship manager |
    ship := Spaceship withName: 'Back'.
    ship moveTo: 2.
    manager := PositionManager forShips: { ship }.
    manager moveShip: ship by: -5.
    self assert: ship position equals: 0.
    self assert: (manager positionOf: ship) equals: 0.
]

{ #category : 'tests - instance' }
PositionManagerTest >> testMoveShipForwardUpdatesPosition [

	| ship manager |
	ship := Spaceship withName: 'Runner'.
	manager := PositionManager forShips: { ship }.
	manager moveShip: ship by: 3.
	self assert: ship position equals: 3.
	self assert: (manager positionOf: ship) equals: 3
]

{ #category : 'tests - instance' }
PositionManagerTest >> testMoveShipToUpdatesPosition [

	| ship manager |
	ship := Spaceship withName: 'Mover'.
	manager := PositionManager forShips: { ship }.
	manager moveShip: ship to: 4.
	self assert: ship position equals: 4.
	self assert: (manager positionOf: ship) equals: 4
]

{ #category : 'tests - instance' }
PositionManagerTest >> testMultipleSequentialMoves [

	| ship manager |
	ship := Spaceship withName: 'Sequential'.
	manager := PositionManager forShips: { ship }.

	manager moveShip: ship by: 3.
	self assert: ship position equals: 3.

	manager moveShip: ship by: -1.
	self assert: ship position equals: 2.

	manager moveShip: ship to: 5.
	self assert: ship position equals: 5.

	manager moveShip: ship by: -10.
	self assert: ship position equals: 0
]

{ #category : 'tests - instance' }
PositionManagerTest >> testPositionOfReturnsCurrentPosition [

	| ship manager |
	ship := Spaceship withName: 'Query'.
	manager := PositionManager forShips: { ship }.
	manager moveShip: ship by: 2.
	self assert: (manager positionOf: ship) equals: 2
]

{ #category : 'tests - instance' }
PositionManagerTest >> testPositionsReturnsAllPositions [

	| ship1 ship2 manager positions |
	ship1 := Spaceship withName: 'Ship1'.
	ship2 := Spaceship withName: 'Ship2'.
	manager := PositionManager forShips: {
			           ship1.
			           ship2 }.

	manager moveShip: ship1 to: 3.
	manager moveShip: ship2 to: 7.

	positions := manager positions.
	self assert: (positions at: ship1) equals: 3.
	self assert: (positions at: ship2) equals: 7
]
