Class {
	#name : 'AtomicBombEffect',
	#superclass : 'EffectDecorator',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBombEffect >> applyEffectTo: aSpaceship inBoard: aBoard [

	(aBoard shipsOnBoard ifNil: [ ^ self ]) do: [ :ship |
		aBoard moveShip: ship to: 0 ]
]

{ #category : 'operations' }
AtomicBombEffect >> applyInvertedTo: aSpaceship inBoard: aBoard [
    ^ self
]
