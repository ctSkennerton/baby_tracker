Class {
	#name : #SoiledDiaperEvent,
	#superclass : #DaiperChangeEvent,
	#category : #BabyTracker
}

{ #category : #displaying }
SoiledDiaperEvent class >> startLabel [ 
	^'Soiled Diaper'
]

{ #category : #initialization }
SoiledDiaperEvent >> initialize [
	super initialize .
	daiperType := 'Poop'
]
