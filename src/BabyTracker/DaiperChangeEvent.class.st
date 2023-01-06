Class {
	#name : #DaiperChangeEvent,
	#superclass : #PointInTimeBabyEvent,
	#instVars : [
		'daiperType'
	],
	#category : #BabyTracker
}

{ #category : #public }
DaiperChangeEvent class >> reStoreDefinition [ 

	^ super reStoreDefinition 
		define: #daiperType as: String;
		yourself
]

{ #category : #'as yet unclassified' }
DaiperChangeEvent class >> startLabel [

	^ 'Daiper Change'
]

{ #category : #accessing }
DaiperChangeEvent >> daiperType [
	"Get the condition of the daiper"

	^ daiperType
]

{ #category : #accessing }
DaiperChangeEvent >> daiperType: aString [

	"Set the condition of the daiper: Mixed, Pee, Poop"

	daiperType := aString
]

{ #category : #printing }
DaiperChangeEvent >> displayStringOn: aStream [

	aStream
		nextPutAll: self class startLabel;
		nextPutAll: ' @ ';
		nextPutAll: startTime monthAbbreviation;
		nextPutAll: ' '.
	startTime dayOfMonth
		printOn: aStream
		base: 10
		length: 2
		padded: true.
	aStream nextPutAll: ' '.
	startTime hour12
		printOn: aStream
		"base: 10
		length: 2
		padded: true".
	aStream nextPutAll: ':'.
	startTime minutes
		printOn: aStream
		base: 10
		length: 2
		padded: true.
	aStream
		nextPutAll: ' ';
		nextPutAll: startTime meridianAbbreviation
	"self startTime asDate printOn: aStream.
	aStream nextPutAll: ' '.
	self startTime asTime print24: false showSeconds: false on: aStream"
]

{ #category : #accessing }
DaiperChangeEvent >> editView [

	"comment stating purpose of instance-side method"

	^ DiaperChangeView 
]

{ #category : #initialization }
DaiperChangeEvent >> initialize [

	type := 'Daiper Change'.
	daiperType := 'Unknown'
]
