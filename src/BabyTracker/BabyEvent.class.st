Class {
	#name : #BabyEvent,
	#superclass : #Object,
	#instVars : [
		'type',
		'startTime',
		'description'
	],
	#classVars : [
		'Database'
	],
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
BabyEvent class >> createSampleDatabase [
			
	Database := OrderedCollection new
]

{ #category : #accessing }
BabyEvent class >> events [
	self storedInstances sortBlock: [ :p1 :p2 | p1 startTime < p2 startTime ].

	^ self storedInstances
	"Database ifNil: [ self createSampleDatabase ].
	^ Database"
]

{ #category : #'instance creation' }
BabyEvent class >> now [

	^ self new
		  startTime: DateAndTime now;
		  store;
		  yourself
]

{ #category : #public }
BabyEvent class >> reStoreDefinition [

	^ super reStoreDefinition
		  define: #startTime as: DateAndTime;
		  define: #type as: (String maxSize: 20);
		  define: #description as: String;
		  yourself
]

{ #category : #adding }
BabyEvent class >> removeEvent: aBabyEvent [

	aBabyEvent unstore
]

{ #category : #'as yet unclassified' }
BabyEvent class >> startLabel [

	self subclassResponsibility 
]

{ #category : #'instance creation' }
BabyEvent class >> type: aString atTime: aTimestamp [

	^ self new
		  type: aString;
		  startTime: aTimestamp;
		  endTime: aTimestamp ;
		  store;
		  yourself
]

{ #category : #accessing }
BabyEvent >> description [

	^ description
]

{ #category : #accessing }
BabyEvent >> description: anObject [

	description := anObject
]

{ #category : #accessing }
BabyEvent >> startDate [

	^ self startTime asDate
]

{ #category : #accessing }
BabyEvent >> startTime [

	^ startTime
]

{ #category : #accessing }
BabyEvent >> startTime: anObject [

	startTime := anObject
]

{ #category : #accessing }
BabyEvent >> type [

	^ type
]

{ #category : #accessing }
BabyEvent >> type: anObject [

	type := anObject
]
