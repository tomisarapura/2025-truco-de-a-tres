Class {
	#name : 'AllyCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AllyCardTest >> testActivateForAddsCardToOwnerAndAlly [
    | owner ally card |
    owner := Spaceship withName: 'Owner'.
    ally := Spaceship withName: 'Ally'.
    card := AllyCard withAlly: ally.
    card activateFor: owner inGame: nil.
    self assert: (owner activeCards includes: card).
    self assert: (ally activeCards includes: card).
    self assert: (card allyFor: ally) equals: owner.
]

{ #category : 'tests' }
AllyCardTest >> testAllyForReturnsCorrectShip [
    | owner ally other card |
    owner := Spaceship withName: 'Owner'.
    ally := Spaceship withName: 'Ally'.
    other := Spaceship withName: 'Other'.
    card := AllyCard withAlly: ally.
    card activateFor: owner inGame: nil.
    self assert: (card allyFor: owner) equals: ally.
    self assert: (card allyFor: ally) equals: owner.
    self assert: (card allyFor: other) isNil.
]
