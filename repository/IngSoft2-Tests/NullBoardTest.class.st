Class {
	#name : 'NullBoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipBackwardMovesShipProperly [

	| board ship |
	board := NullBoard new.
	ship := Spaceship withName: 'Voyager'.
	ship moveTo: 3.
	board moveShip: ship backward: 2.
	self assert: ship position equals: 1
]

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipBackwardWithNegativeStepsDoesNotMoveBelowZero [

	| board ship |
	board := NullBoard new.
	ship := Spaceship withName: 'John Doe'.
	ship moveTo: 1.
	board moveShip: ship backward: 2.
	self assert: ship position equals: 0
]

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipForwardMovesShipProperly [

	| board ship |
	board := NullBoard new.
	ship := Spaceship withName: 'Enterprise'.
	board moveShip: ship forward: 3.
	self assert: ship position equals: 3
]

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipForwardWithNegativeStepsDoesNotMoveBelowZero [

	| board ship |
	board := NullBoard new.
	ship := Spaceship withName: 'Enterprise'.
	ship moveTo: 0.
	board moveShip: ship forward: -3.
	self assert: ship position equals: 0
]

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipToNegativePositionSetsToZero [

	| board ship |
	board := NullBoard new.
	ship := Spaceship withName: 'John Doe'.
	board moveShip: ship to: -5.
	self assert: ship position equals: 0
]

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipToSetsExactPosition [

	| board ship |
	board := NullBoard new.
	ship := Spaceship withName: 'Discovery'.
	board moveShip: ship to: 5.
	self assert: ship position equals: 5
]

{ #category : 'tests - instance' }
NullBoardTest >> testMultipleMoveOperations [
    | board ship |
    board := NullBoard new.
    ship := Spaceship withName: 'John Dow'.
    
    board moveShip: ship to: 0.
    self assert: ship position equals: 0.
    
    board moveShip: ship forward: 5.
    self assert: ship position equals: 5.
    
    board moveShip: ship backward: 3.
    self assert: ship position equals: 2.
    
    board moveShip: ship to: 10.
    self assert: ship position equals: 10.
]

{ #category : 'tests - instance' }
NullBoardTest >> testShipsOnBoardReturnsEmptyCollection [

	| board |
	board := NullBoard new.
	self assert: board shipsOnBoard isEmpty
]
