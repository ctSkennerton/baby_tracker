Class {
	#name : #SleepBabyEvent,
	#superclass : #DurationBabyEvent,
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
SleepBabyEvent class >> endLabel [ 
	^ 'Wake'
]

{ #category : #'as yet unclassified' }
SleepBabyEvent class >> startLabel [ 
	^ 'Sleep'
]

{ #category : #initialization }
SleepBabyEvent >> initialize [

	type := 'Sleep'
]
