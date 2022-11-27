Class {
	#name : #NursingEvent,
	#superclass : #DurationBabyEvent,
	#instVars : [
		'firstSide',
		'secondSide'
	],
	#category : #BabyTracker
}

{ #category : #displaying }
NursingEvent class >> endLabel [

	^ 'End Nursing'
]

{ #category : #public }
NursingEvent class >> reStoreDefinition [

	^ super reStoreDefinition
		  define: #firstSide as: String;
		define: #secondSide as: String;
		  yourself
]

{ #category : #displaying }
NursingEvent class >> startLabel [
	^ 'Start Nursing'
]

{ #category : #accessing }
NursingEvent >> firstSide [

	^ firstSide
]

{ #category : #accessing }
NursingEvent >> firstSide: anObject [

	firstSide := anObject
]

{ #category : #initialization }
NursingEvent >> initialize [ 

	type := 'Nursing'
]

{ #category : #accessing }
NursingEvent >> secondSide [

	^ secondSide
]

{ #category : #accessing }
NursingEvent >> secondSide: anObject [

	secondSide := anObject
]
