Class {
	#name : #Baby,
	#superclass : #Object,
	#instVars : [
		'name',
		'dob',
		'events',
		'measurements'
	],
	#category : #BabyTracker
}

{ #category : #public }
Baby class >> reStoreDefinition [

	^ super reStoreDefinition
		  define: #name as: (String maxSize: 200);
		  define: #dob as: Date;
		  define: #events as: (OrderedCollection of: BabyEvent owner: #baby);
		  define: #measurements as: (OrderedCollection of: BabyMeasurement owner: #baby);
		  yourself
]

{ #category : #adding }
Baby >> addEvent: aBabyEvent [

	aBabyEvent baby: self.
	events add: aBabyEvent.
	
	self store
]

{ #category : #adding }
Baby >> addMeasurement: aBabyMeasurement [

	aBabyMeasurement baby: self.
	events add: aBabyMeasurement.
	self store
]

{ #category : #accessing }
Baby >> dob [

	^ dob
]

{ #category : #accessing }
Baby >> dob: anObject [

	dob := anObject
]

{ #category : #accessing }
Baby >> events [

	^ events ifNil: [ events := OrderedCollection new ]
]

{ #category : #accessing }
Baby >> events: anObject [

	events := anObject
]

{ #category : #initialization }
Baby >> initialize [

	events := OrderedCollection new.
	measurements := OrderedCollection new
]

{ #category : #accessing }
Baby >> measurements [

	^ measurements ifNil: [ measurements := OrderedCollection new ]
]

{ #category : #accessing }
Baby >> measurements: anObject [

	measurements := anObject
]

{ #category : #accessing }
Baby >> name [

	^ name
]

{ #category : #accessing }
Baby >> name: anObject [

	name := anObject
]
