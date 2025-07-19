Class {
	#name : 'AtomicBombEffect',
	#superclass : 'EffectDecorator',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBombEffect >> applyEffectTo: aSpaceship inBoard: aBoard [
    
	aBoard shipsOnBoard do: [:ship |
        aBoard moveShip: ship to: 0
    ].
]

{ #category : 'operations' }
AtomicBombEffect >> applyInvertedTo: aSpaceship inBoard: aBoard [
    ^ self
]

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship inContextOf: allSpaceships inBoard: aBoard [
    | board |
    board := aBoard ifNil: [ NullBoard new ] ifNotNil: [ aBoard ].
    allSpaceships do: [:ship |
        board moveShip: ship to: 0
    ].
]
