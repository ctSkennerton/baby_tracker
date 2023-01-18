Class {
	#name : #DurationBabyEvent,
	#superclass : #BabyEvent,
	#instVars : [
		'endTime'
	],
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
DurationBabyEvent class >> endLabel [

	self subclassResponsibility
]

{ #category : #public }
DurationBabyEvent class >> reStoreDefinition [

	^ super reStoreDefinition
		  define: #endTime as: DateAndTime;
		  yourself
]

{ #category : #'as yet unclassified' }
DurationBabyEvent >> displayDurationTimesOn: aStream [

	"comment stating purpose of instance-side method"
	self 
]

{ #category : #printing }
DurationBabyEvent >> displayStringOn: aStream [

	super displayStringOn: aStream.
	endTime ifNotNil: [ 
		aStream nextPutAll: ' to '.
		startTime asDate = endTime asDate ifFalse: [ 
			aStream
				nextPutAll: endTime monthAbbreviation;
				nextPutAll: ' '.
			endTime dayOfMonth
				printOn: aStream
				base: 10
				length: 2
				padded: true.
			aStream nextPutAll: ' ' ].
		endTime hour12 printOn: aStream.

		aStream nextPutAll: ':'.
		endTime minutes
			printOn: aStream
			base: 10
			length: 2
			padded: true.
		aStream
			nextPutAll: ' ';
			nextPutAll: endTime meridianAbbreviation
]
]

{ #category : #accessing }
DurationBabyEvent >> duration [

	^ self endTime - self startTime
]

{ #category : #accessing }
DurationBabyEvent >> durationInSeconds [

	^ self endTime asUnixTime  - self startTime asUnixTime 
]

{ #category : #accessing }
DurationBabyEvent >> durationPerDay [

	^ self startTime asDate = self endTime asDate
		  ifTrue: [ Dictionary newFromKeys: { self startTime asDate } andValues: { self endTime - self startTime }
			  ]
		  ifFalse: [ 
			  Dictionary
				  newFromKeys: { 
						  self startTime asDate.
						  self endTime asDate }
				  andValues: { self endTime asDate - self startTime. self endTime - self endTime asDate } ]
]

{ #category : #accessing }
DurationBabyEvent >> editView [ 
	"comment stating purpose of instance-side method"
	^ DurationEventView 
]

{ #category : #accessing }
DurationBabyEvent >> endTime [

	^ endTime
]

{ #category : #accessing }
DurationBabyEvent >> endTime: anObject [

	endTime := anObject
]
