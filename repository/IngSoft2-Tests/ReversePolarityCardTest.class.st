Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReversePolarityCardTest >> testCreateCardWithTargetCell [

	| card cell |
	cell := 5.
	card := ReversePolarityCard forCell: cell.
	self assert: card targetCell equals: cell
]
