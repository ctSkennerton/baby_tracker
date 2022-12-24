Class {
	#name : #WetDiaperEvent,
	#superclass : #DaiperChangeEvent,
	#category : #BabyTracker
}

{ #category : #displaying }
WetDiaperEvent class >> startLabel [ 
	^ 'Wet Diaper'
]

{ #category : #initialization }
WetDiaperEvent >> initialize [
	super initialize .
	daiperType := 'Pee'
]
