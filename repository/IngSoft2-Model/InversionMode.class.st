Class {
	#name : 'InversionMode',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'method' }
InversionMode >> applyEffect: anEffect to: aSpaceship inBoard: aBoard [

	self subclassResponsibility
]

{ #category : 'method' }
InversionMode >> applyWormholeEffect: aWormhole at: aPosition inBoard: aBoard [

	self subclassResponsibility
]
