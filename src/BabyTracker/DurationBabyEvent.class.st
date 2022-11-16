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

{ #category : #accessing }
DurationBabyEvent >> duration [

	^ self endTime - self startTime
]

{ #category : #accessing }
DurationBabyEvent >> durationInSeconds [

	^ self endTime asUnixTime  - self startTime asUnixTime 
]

{ #category : #accessing }
DurationBabyEvent >> endTime [

	^ endTime ifNil: [ endTime := startTime  ]
]

{ #category : #accessing }
DurationBabyEvent >> endTime: anObject [

	endTime := anObject
]
