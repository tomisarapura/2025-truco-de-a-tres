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
ReversePolarityCardTest >> testEvenNumberOfReversePolarityCardsCancelOut [

	| card1 card2 card3 card4 ship otherShip board game |
	card1 := ReversePolarityCard forCell: 5.
	card2 := ReversePolarityCard forCell: 5.
	card3 := ReversePolarityCard forCell: 5.
	card4 := ReversePolarityCard forCell: 5.

	ship := Spaceship withName: 'Ship'.
	otherShip := Spaceship withName: 'OtherShip'.

	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: HyperGravityEffect new toCell: 5.

	game := Game
		        startWithShips: {
				        ship.
				        otherShip }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	card1 activateFor: ship inGame: game.
	card2 activateFor: ship inGame: game.
	card3 activateFor: ship inGame: game.
	card4 activateFor: ship inGame: game.

	board moveShip: ship to: 5.
	board moveShip: otherShip to: 8.

	board applyEffectTo: ship.

	self assert: ship position equals: 5 - 1.
	self assert: otherShip position equals: 8.
	self assert: ship remainingTurbines equals: 2
]

{ #category : 'invertedEffects' }
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

{ #category : 'invertedEffects' }
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

{ #category : 'invertedEffects' }
ReversePolarityCardTest >> testInvertedCardEffectGivesCardsToOthers [

	| card cell ship1 ship2 ship3 board game initialCards |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	ship1 := Spaceship withName: 'Ship1'.
	ship2 := Spaceship withName: 'Ship2'.
	ship3 := Spaceship withName: 'Ship3'.

	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: CardEffect new toCell: cell.

	game := Game
		        startWithShips: {
				        ship1.
				        ship2.
				        ship3 }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	initialCards := ship2 cards size.
	card activateFor: ship1 inGame: game.
	board moveShip: ship1 to: cell.
	board applyEffectTo: ship1.

	self assert: ship1 cards size equals: 2. 
	self assert: ship2 cards size equals: initialCards + 1. 
	self assert: ship3 cards size equals: initialCards + 1
]

{ #category : 'invertedEffects' }
ReversePolarityCardTest >> testInvertedHyperGravityAffectsOthers [

	| card cell ship otherShip board game hyperGravity |
	cell := 5.
	hyperGravity := HyperGravityEffect new.

	card := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'Main Ship'.
	otherShip := Spaceship withName: 'Other Ship'.

	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: hyperGravity toCell: cell.

	game := Game
		        startWithShips: {
				        ship.
				        otherShip }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	board moveShip: ship to: cell.
	board moveShip: otherShip to: 8.

	card activateFor: ship inGame: game.
	board applyEffectTo: ship.

	self assert: ship position equals: cell.
	self assert: otherShip position equals: 8 - 1.
	self assert: otherShip remainingTurbines equals: 2
]

{ #category : 'invertedEffects' }
ReversePolarityCardTest >> testInvertedHyperGravityWhenMultipleReversePolarityCardsCancelOut [

	| card1 card2 cell ship otherShip board game hyperGravity |
	cell := 5.
	hyperGravity := HyperGravityEffect new.

	card1 := ReversePolarityCard forCell: cell.
	card2 := ReversePolarityCard forCell: cell.
	ship := Spaceship withName: 'Ship 1'.
	otherShip := Spaceship withName: 'Ship 2'.

	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: hyperGravity toCell: cell.

	game := Game
		        startWithShips: {
				        ship.
				        otherShip }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 6) })
		        laps: 1.


	board moveShip: ship to: cell.
	board moveShip: otherShip to: 8.

	card1 activateFor: ship inGame: game.
	card2 activateFor: ship inGame: game.

	board applyEffectTo: ship.

	self assert: ship position equals: cell - 1. 
	self assert: otherShip position equals: 8.
	self assert: ship remainingTurbines equals: 2
]

{ #category : 'invertedEffects' }
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

{ #category : 'invertedEffects' }
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

{ #category : 'invertedEffects' }
ReversePolarityCardTest >> testInvertedNoEffectDoesNothing [

	| card ship1 ship2 board game |
	card := ReversePolarityCard forCell: 3.
	ship1 := Spaceship withName: 'Ship1'.
	ship2 := Spaceship withName: 'Ship2'.
	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: NoEffect new toCell: 3.
	game := Game
		        startWithShips: {
				        ship1.
				        ship2 }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	card activateFor: ship1 inGame: game.
	board moveShip: ship1 to: 3.
	board applyEffectTo: ship1.

	self assert: ship1 position equals: 3
]

{ #category : 'invertedEffects' }
ReversePolarityCardTest >> testInvertedWormholeAffectsOthers [
	| card cell ship1 ship2 wormhole board game |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	
	wormhole := Wormhole from: 5 to: 8.
	
	ship1 := Spaceship withName: 'Ship 1'.
	ship2 := Spaceship withName: 'Ship 2'.
	
	board := Board of: 10 andWormholeAt: { wormhole }.
	
	game := Game
		startWithShips: { ship1. ship2 }
		board: board
		dice: (DiceCup with: { Die withSides: 1 })
		laps: 1.
	
	card activateFor: ship1 inGame: game.
	board moveShip: ship2 to: 3.
	board moveShip: ship1 to: cell.

	self assert: ship1 position equals: 5.
	self assert: ship2 position equals: 8.
	self assert: (ship1 activeCards includes: card).

]

{ #category : 'tests' }
ReversePolarityCardTest >> testOddNumberOfReversePolarityCardsInvertEffect [
    | card1 card2 card3 ship otherShip board game  |
    
    card1 := ReversePolarityCard forCell: 4.
    card2 := ReversePolarityCard forCell: 4.
    card3 := ReversePolarityCard forCell: 4.
    
    ship := Spaceship withName: 'Ship'.
    otherShip := Spaceship withName: 'OtherShip'.
    
    board := Board of: 10 andWormholeAt: #().
    board assignEffect: MoonWalkEffect new toCell: 4.
    
    game := Game
            startWithShips: { ship. otherShip }
            board: board
            dice: (DiceCup with: { (Die withSides: 1) })
            laps: 1.
    
    card1 activateFor: ship inGame: game.
    card2 activateFor: ship inGame: game.
    card3 activateFor: ship inGame: game.
    
    board moveShip: ship to: 4.
    board moveShip: otherShip to: 7.
    
    board applyEffectTo: ship.
    
    self assert: ship position equals: 4.
    self assert: otherShip position equals: 7. 
]

{ #category : 'tests' }
ReversePolarityCardTest >> testRemovingReversePolarityCardsChangesEffect [

	| card1 card2 ship otherShip board game cancellationCard |
	card1 := ReversePolarityCard forCell: 5.
	card2 := ReversePolarityCard forCell: 5.

	ship := Spaceship withName: 'Main Ship'.
	otherShip := Spaceship withName: 'Other Ship'.

	board := Board of: 10 andWormholeAt: #(  ).
	board assignEffect: HyperGravityEffect new toCell: 5.

	game := Game
		        startWithShips: {
				        ship.
				        otherShip }
		        board: board
		        dice: (DiceCup with: { (Die withSides: 1) })
		        laps: 1.

	"Activar dos cartas (deberían cancelarse)"
	card1 activateFor: ship inGame: game.
	card2 activateFor: ship inGame: game.

	cancellationCard := CancellationCard cancelling: card1.
	cancellationCard playOn: ship inGame: game.

	board moveShip: ship to: 5.
	board moveShip: otherShip to: 8.

	board applyEffectTo: ship.

	self assert: ship position equals: 5.
	self assert: otherShip position equals: 8 - 1
]
