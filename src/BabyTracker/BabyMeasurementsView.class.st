Class {
	#name : #BabyMeasurementsView,
	#superclass : #WAComponent,
	#instVars : [
		'baby',
		'recordNewMeasurements',
		'plotView'
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

{ #category : #hooks }
BabyMeasurementsView >> children [

	^ Array with: recordNewMeasurements with: plotView
]

{ #category : #initialization }
BabyMeasurementsView >> initialize [

	super initialize.
	recordNewMeasurements := RecordBabyMeasurement new.
	plotView := BabyMeasurementPlotView new
]

{ #category : #rendering }
BabyMeasurementsView >> renderContentOn: html [

	| recordedMeasures |
	html heading: 'Measurements'.
	html anchor
		attributeAt: 'role' put: 'button';
		class: 'btn btn-outline-dark';
		callback: [ 
			recordedMeasures := self call: (RecordBabyMeasurement new
						                     baby: self baby;
						                     yourself).
			recordedMeasures ifNotNil: [ 
				recordedMeasures do: [ :each | baby addMeasurement: each ] ] ];
		with: [ "html render: recordNewMeasurements" 
			html strong with: 'New Measurement' ].
	html render: plotView
]
