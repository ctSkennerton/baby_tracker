Class {
	#name : #BabyTrackerSession,
	#superclass : #WASession,
	#category : #BabyTracker
}

{ #category : #'connection open/close' }
BabyTrackerSession >> connect [

	ReStore isConnected ifFalse: [ 
		ReStore
			connection: (SSWSQLite3Connection on:
						 (Smalltalk imageDirectory / 'data' / 'babytracker.db') fullName);
			connect;
			addClass: Baby;
			addClassWithSubclasses: BabyEvent;
			addClassWithSubclasses: BabyMeasurement;
			synchronizeAllClasses ]
]

{ #category : #'as yet unclassified' }
BabyTrackerSession >> currentBaby [

	^ Baby storedInstances isEmpty
		  ifTrue: [ nil ]
		  ifFalse: [ Baby storedInstances first ]
]

{ #category : #'connection open/close' }
BabyTrackerSession >> disconnect [
	ReStore disconnect
]

{ #category : #initialization }
BabyTrackerSession >> initialize [

	super initialize.
	self connect.
	self initialzeCustomSql.
]

{ #category : #'as yet unclassified' }
BabyTrackerSession >> initialzeCustomSql [

	"set up custom translations for ReStore to translate to Sqlite3"

	ReStore
		translateMessage: #asDate
		toFunction: ('date(%1)' asSQLFunctionWithResultClass: Date).

	ReStore
		translateMessage: #asLocalDate
		toFunction:
		('date(%1, ''localtime'')' asSQLFunctionWithResultClass: Date)
]
