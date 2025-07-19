Class {
	#name : 'MoonWalkEffect',
	#superclass : 'EffectDecorator',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
MoonWalkEffect >> applyEffectTo: aSpaceship inBoard: aBoard [

	aBoard shipsOnBoard do: [ :ship |
		ship = aSpaceship ifFalse: [ aBoard moveShip: ship backward: 2 ] ]
]
