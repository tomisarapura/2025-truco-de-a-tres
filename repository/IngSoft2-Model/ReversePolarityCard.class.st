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
ReversePolarityCard class >> for: aCell [

	^ self new initializeForCell: aCell
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
