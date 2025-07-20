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
ReversePolarityCardTest >> testInvertedAtomicBombAffectsNobody [

	| card cell ship otherShip board game |
	cell := 7.
	card := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'John Doe'.
	otherShip := Spaceship withName: 'Jane Doe'.
	board := Board of: 10 andWormholeAt: {  }.
	board assignEffect: AtomicBombEffect new toCell: 7.
	game := Game
		        startWithShips: {
				        ship.
				        otherShip }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	ship moveTo: 3.
	otherShip moveTo: 8.
	card activateFor: ship inGame: game.
	board moveShip: ship to: cell.
	board applyEffectTo: ship.

	self assert: ship position equals: cell.
	self assert: otherShip position equals: 8
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedBlackHoleAffectsOthers [

	| card cell ship otherShip board game |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'John Doe'.
	otherShip := Spaceship withName: 'Jane Doe'.
	board := Board of: 10 andWormholeAt: {  }.
	board assignEffect: BlackHoleEffect new toCell: 5.
	game := Game
		        startWithShips: {
				        ship.
				        otherShip }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.
		
	board moveShip: ship to: 5.
	board moveShip: otherShip to: 8.
	card activateFor: ship inGame: game.
	board moveShip: ship to: cell.
	board applyEffectTo: ship.

	self assert: otherShip position equals: 8 - 4.
	self assert: ship position equals: cell
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedCardEffectAffectsOthers [

	| card cell ship otherShip1 otherShip2 board game initialCards |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'John Doe'.
	otherShip1 := Spaceship withName: 'Jane Doe'.
	otherShip2 := Spaceship withName: 'Bob Smith'.

	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: CardEffect new toCell: cell.

	game := Game
		        startWithShips: {
				        ship.
				        otherShip1.
				        otherShip2 }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	initialCards := ship cards size.

	card activateFor: ship inGame: game.

	board moveShip: ship to: cell.
	board applyEffectTo: ship.

	self assert: ship cards size equals: initialCards.
	self assert: otherShip1 cards size equals: initialCards + 1.
	self assert: otherShip2 cards size equals: initialCards + 1
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedHyperGravityAffectsOthers [

	| card cell ship1 ship2 board game |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	ship1 := Spaceship withName: 'John Doe'.
	ship2 := Spaceship withName: 'Jane Doe'.
	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: HyperGravityEffect new toCell: cell.
	game := Game
		        startWithShips: {
				        ship1.
				        ship2 }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	board moveShip: ship1 to: 3.
	board moveShip: ship2 to: 8.

	card activateFor: ship1 inGame: game.
	board moveShip: ship1 to: cell.
	board applyEffectTo: ship1.

	self assert: ship1 position equals: cell.
	self assert: ship1 remainingTurbines equals: 3.
	self assert: ship2 position equals: 7.
	self assert: ship2 remainingTurbines equals: 2
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedHyperGravityDoesNotAffectSelf [

	| card cell ship1 ship2 board game |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	ship1 := Spaceship withName: 'John Doe'.
	ship2 := Spaceship withName: 'Jane Doe'.
	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: HyperGravityEffect new toCell: cell.
	game := Game
		        startWithShips: {
				        ship1.
				        ship2 }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	board moveShip: ship1 to: 3.
	board moveShip: ship2 to: 8.

	card activateFor: ship1 inGame: game.
	board moveShip: ship1 to: cell.
	board applyEffectTo: ship1.

	self assert: ship1 position equals: cell.
	self assert: ship1 remainingTurbines equals: 3
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedHyperJumpAffectsOthers [
	| card cell ship otherShip board game hyperJump |
	cell := 5.
	hyperJump := HyperJumpEffect withValues: #(10). "10 parsecs"
	
	card := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'John Doe'.
	otherShip := Spaceship withName: 'Jane Doe'.
	board := Board
		of: 100
		length: 100
		andWormholeAt: {}.
	
	board assignEffect: hyperJump toCell: cell.
	
	game := Game
		startWithShips: { ship. otherShip }
		board: board
		dice: (DiceCup with: { Die withSides: 1 })
		laps: 1.

	board moveShip: otherShip to: 8.  
	card activateFor: ship inGame: game.  
	board moveShip: ship to: cell.     

	board applyEffectTo: ship.

	self assert: otherShip position equals: 8 + 10.  
	self assert: ship position equals: cell.      
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedMoonWalkAffectsNobody [

	| card cell ship otherShip board game |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'John Doe'.
	otherShip := Spaceship withName: 'Jane Doe'.
	board := Board of: 10 andWormholeAt: {  }.
	board assignEffect: MoonWalkEffect new toCell: 5.
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

	self assert: ship position equals: 5.
	self assert: otherShip position equals: 8.
	self assert: ship position equals: cell
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedNoEffectAffectsNobody [

	| card cell ship otherShip board game |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'John Doe'.
	otherShip := Spaceship withName: 'Jane Doe'.
	board := Board of: 10 andWormholeAt: {  }.
	board assignEffect: NoEffect new toCell: 5.
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

	self assert: ship position equals: 5.
	self assert: otherShip position equals: 8.
	self assert: ship position equals: cell
]

{ #category : 'tests' }
ReversePolarityCardTest >> testInvertedWormholeAffectsOthers [

	| card cell ship1 ship2 board game wormhole |
	cell := 5.
	wormhole := Wormhole from: 5 to: 9.

	card := ReversePolarityCard forCell: cell.
	ship1 := Spaceship withName: 'John Doe'.
	ship2 := Spaceship withName: 'Jane Doe'.

	board := Board of: 10 andWormholeAt: { wormhole }.
	game := Game
		        startWithShips: {
				        ship1.
				        ship2 }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	board moveShip: ship1 to: 0.
	board moveShip: ship2 to: 3.

	card activateFor: ship1 inGame: game.

	board moveShip: ship1 to: cell.
	board applyEffectTo: ship1.

	self assert: ship1 position equals: 5.
	self assert: ship2 position equals: 9
]
