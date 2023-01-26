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

{ #category : #printing }
NursingEvent >> displayStringOn: aStream [

	aStream
		nextPutAll: self type;
		nextPutAll: ': ';
		nextPutAll: self firstSide;
		nextPutAll: ' side';
		nextPutAll: ' @ '.
	self startTime bt_printShortOn: aStream.
	self displayDurationTimesOn: aStream
]

{ #category : #accessing }
NursingEvent >> editView [ 

	"comment stating purpose of instance-side method"

	^ NursingEventView 
]

{ #category : #accessing }
NursingEvent >> firstSide [

	^firstSide ifNil: [ 'NOT SET' ] ifNotNil: [ firstSide ]
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

	^ secondSide ifNil: [ 'NOT SET' ] ifNotNil: [ secondSide  ]
]

{ #category : #accessing }
NursingEvent >> secondSide: anObject [

	secondSide := anObject
]
