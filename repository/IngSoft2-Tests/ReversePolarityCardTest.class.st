Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReversePolarityCardTest >> testActivateCardAddsToActiveCards [

	| card ship1 ship2 board dice game |
	card := ReversePolarityCard forCell: 3.
	ship1 := Spaceship withName: 'John Doe'.
	ship2 := Spaceship withName: 'B'.

	board := Board of: 10 andWormholeAt: #(  ).
	dice := DiceCup with: { (Die withSides: 1) }.

	game := Game
		        startWithShips: {
				        ship1.
				        ship2 }
		        board: board
		        dice: dice
		        laps: 1.
		
	card activateFor: ship1 inGame: game.
	self assert: (ship1 activeCards includes: card)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testCreateCardWithTargetCell [

	| card cell |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	self assert: card targetCell equals: cell
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedBlackHoleAffectsOthers [

	| card cell ship otherShip board game |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'John Doe'.
	otherShip := Spaceship withName: 'Jane Doe'.
	board := Board of: 10 andWormholeAt: {  }.
	game := Game
		        startWithShips: {
				        ship.
				        otherShip }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	board moveShip: otherShip to: 8.
	card activateFor: ship inGame: game.
	board moveShip: ship to: cell.
	board applyEffectTo: ship.

	self assert: otherShip position equals: 8 - 4.
	self assert: ship position equals: cell
]
