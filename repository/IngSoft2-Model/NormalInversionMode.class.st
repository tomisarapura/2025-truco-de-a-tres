Class {
	#name : 'NormalInversionMode',
	#superclass : 'InversionMode',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'method' }
NormalInversionMode >> applyEffect: anEffect to: aSpaceship inBoard: aBoard [

	anEffect applyTo: aSpaceship inBoard: aBoard
]

{ #category : 'method' }
NormalInversionMode >> applyWormholeEffect: aWormhole at: aPosition inBoard: aBoard [

	^ aWormhole exit
]
