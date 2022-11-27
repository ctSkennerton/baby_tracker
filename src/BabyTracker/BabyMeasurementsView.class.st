Class {
	#name : #BabyMeasurementsView,
	#superclass : #WAComponent,
	#instVars : [
		'baby',
		'recordNewMeasurements'
	],
	#category : #BabyTracker
}

{ #category : #'instance creation' }
BabyMeasurementsView class >> with: aBaby [

	^self new
		baby: aBaby;
		yourself
]

{ #category : #accessing }
BabyMeasurementsView >> baby [

	^ baby ifNil: [ baby:= Baby storedInstances first ]
]

{ #category : #accessing }
BabyMeasurementsView >> baby: anObject [

	baby := anObject
]

{ #category : #initialization }
BabyMeasurementsView >> children [

	^ Array with: recordNewMeasurements 
]

{ #category : #initialization }
BabyMeasurementsView >> initialize [ 

	super initialize .
	recordNewMeasurements := RecordBabyMeasurement new baby: self baby; yourself
]

{ #category : #rendering }
BabyMeasurementsView >> renderContentOn: html [
	| recordedMeasures |
	html heading: 'Measurements'.
	html anchor
		attributeAt: 'role' put: 'button';
		class: 'button';
		callback: [ 
			recordedMeasures := self call: (RecordBabyMeasurement new
						 baby: self baby;
						 yourself). 
			recordedMeasures ifNotNil: [ recordedMeasures do: [ :each | baby addMeasurement: each]  ] ];
		with: [ "html render: recordNewMeasurements" 
			html strong with: 'New Measurement' ]
]