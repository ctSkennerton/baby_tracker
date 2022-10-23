Class {
	#name : #BabyEvent,
	#superclass : #Object,
	#instVars : [
		'type',
		'startTime',
		'endTime'
	],
	#classVars : [
		'Database'
	],
	#category : #BabyTracker
}

{ #category : #adding }
BabyEvent class >> addEvent: aBabyEvent [
	self events add: aBabyEvent 
]

{ #category : #'as yet unclassified' }
BabyEvent class >> createSampleDatabase [
			
	Database := OrderedCollection new
]

{ #category : #accessing }
BabyEvent class >> events [
	Database ifNil: [ self createSampleDatabase ].
    ^ Database
]

{ #category : #adding }
BabyEvent class >> removeEvent: aBabyEvent [
	self events remove: aBabyEvent 
]

{ #category : #'instance creation' }
BabyEvent class >> type: aString atTime: aTimestamp [
	^ self new type: aString; startTime: aTimestamp; yourself
]

{ #category : #accessing }
BabyEvent >> endTime [

	^ endTime
]

{ #category : #accessing }
BabyEvent >> endTime: anObject [

	endTime := anObject
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
