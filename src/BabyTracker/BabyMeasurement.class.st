Class {
	#name : #BabyMeasurement,
	#superclass : #Object,
	#instVars : [
		'type',
		'time',
		'description',
		'value',
		'units',
		'baby'
	],
	#category : #BabyTracker
}

{ #category : #public }
BabyMeasurement class >> reStoreDefinition [

	^ super reStoreDefinition
		  define: #time as: DateAndTime;
		  define: #type as: (String maxSize: 100);
		  define: #description as: String;
		  define: #value as: Float;
		  define: #units as: (String maxSize: 8);
		define: #baby as: Baby;
		  yourself
]

{ #category : #accessing }
BabyMeasurement >> baby [

	^ baby
]

{ #category : #accessing }
BabyMeasurement >> baby: anObject [

	baby := anObject
]

{ #category : #accessing }
BabyMeasurement >> description [

	^ description
]

{ #category : #accessing }
BabyMeasurement >> description: anObject [

	description := anObject
]

{ #category : #accessing }
BabyMeasurement >> measurementValue [

	^ value
]

{ #category : #accessing }
BabyMeasurement >> measurementValue: anObject [

	value := anObject
]

{ #category : #accessing }
BabyMeasurement >> time [

	^ time
]

{ #category : #accessing }
BabyMeasurement >> time: anObject [

	time := anObject
]

{ #category : #accessing }
BabyMeasurement >> type [

	^ type
]

{ #category : #accessing }
BabyMeasurement >> type: anObject [

	type := anObject
]

{ #category : #accessing }
BabyMeasurement >> units [

	^ units
]

{ #category : #accessing }
BabyMeasurement >> units: anObject [

	units := anObject
]
