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
