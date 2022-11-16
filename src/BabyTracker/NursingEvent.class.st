Class {
	#name : #NursingEvent,
	#superclass : #DurationBabyEvent,
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
NursingEvent class >> endLabel [

	^ 'End Nursing'
]

{ #category : #'as yet unclassified' }
NursingEvent class >> startLabel [
	^ 'Start Nursing'
]

{ #category : #initialization }
NursingEvent >> initialize [ 

	type := 'Nursing'
]
