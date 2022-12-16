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
						 (Smalltalk imageDirectory / 'test.db') fullName);
			connect;
			addClass: Baby;
			addClassWithSubclasses: BabyEvent;
			addClassWithSubclasses: BabyMeasurement;
			synchronizeAllClasses ].

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
	self connect
]
