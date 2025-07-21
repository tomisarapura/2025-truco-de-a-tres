Class {
	#name : 'ReversePolarityCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'targetCell'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
ReversePolarityCard class >> forCell: aCell [
	
	self validateCell: aCell.

	^ self new initializeForCell: aCell
]

{ #category : 'initialize' }
ReversePolarityCard class >> validateCell: aCell [

	(aCell isInteger and: aCell >= 0) ifFalse: [ ^ self error: 'Cell has to be postive' ]
]

{ #category : 'playing' }
ReversePolarityCard >> activateFor: aShip inGame: aGame [

	aShip addActiveCard: self
]

{ #category : 'initialize' }
ReversePolarityCard >> initializeForCell: aCell [

	targetCell := aCell.
	^ self
]

{ #category : 'accessing' }
ReversePolarityCard >> targetCell [

	^ targetCell
]
