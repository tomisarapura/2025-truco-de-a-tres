Class {
	#name : 'InvertedInversionMode',
	#superclass : 'InversionMode',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'method' }
InvertedInversionMode >> applyEffect: anEffect to: aSpaceship inBoard: aBoard [

	anEffect applyInvertedTo: aSpaceship inBoard: aBoard
]

{ #category : 'method' }
InvertedInversionMode >> applyWormholeEffect: aWormhole at: aPosition inBoard: aBoard [

	aBoard shipsOnBoard
		reject: [ :ship | ship position = aPosition ]
		thenDo: [ :ship | aBoard moveShip: ship to: aWormhole exit ].
	^ aPosition
]
