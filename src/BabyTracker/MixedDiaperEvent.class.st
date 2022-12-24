Class {
	#name : #MixedDiaperEvent,
	#superclass : #DaiperChangeEvent,
	#category : #BabyTracker
}

{ #category : #displaying }
MixedDiaperEvent class >> startLabel [ 
	^ 'Mixed Diaper'
]

{ #category : #initialization }
MixedDiaperEvent >> initialize [ 
	super initialize .
	daiperType := 'Mixed'
]
