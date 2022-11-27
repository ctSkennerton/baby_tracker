Class {
	#name : #RecordBabyMeasurement,
	#superclass : #WAComponent,
	#instVars : [
		'measures',
		'time',
		'baby'
	],
	#category : #BabyTracker
}

{ #category : #'instance creation' }
RecordBabyMeasurement class >> with: aBaby [

	^ self new baby: aBaby; yourself
]

{ #category : #accessing }
RecordBabyMeasurement >> baby [

	^ baby
]

{ #category : #accessing }
RecordBabyMeasurement >> baby: anObject [

	baby := anObject
]

{ #category : #accessing }
RecordBabyMeasurement >> measures [

	^ measures ifNil: [ measures := OrderedCollection new  ]
]

{ #category : #accessing }
RecordBabyMeasurement >> measures: anObject [

	measures := anObject
]

{ #category : #rendering }
RecordBabyMeasurement >> renderContentOn: html [

	html heading: 'New Measurement'.
	html form: [ 
		html text: 'Time: '.
		html dateTimeLocalInput
			callback: [ :value | self time: value asDateAndTime ];
			value: (DatePrinter with: self time) isoLocal.
		html break.


		html text: 'Length: '.
		html numberInput
			attributeAt: 'step' put: '0.01';
			callback: [ :value | 
				value ifNotEmpty: [ 
						self measures add: (BabyMeasurement new
									 type: 'Length';
									 measurementValue: value asNumber;
									 units: 'in') ] ].

		html text: 'inches'.
		html break.

		html text: 'Weight: '.
		html numberInput
			attributeAt: 'step' put: '0.01';
			callback: [ :value | 
				value ifNotEmpty: [ 
						self measures add: (BabyMeasurement new
									 type: 'Weight';
									 measurementValue: value asNumber;
									 units: 'lb') ] ].

		html text: 'pounds'.
		html break.

		html text: 'Head Circumference: '.
		html numberInput
			attributeAt: 'step' put: '0.01';
			callback: [ :value | 
				value ifNotEmpty: [ self measures add: (BabyMeasurement new
							 type: 'Head Circumference';
							 measurementValue: value asNumber;
							 units: 'in') ]
				 ].

		html text: 'inches'.
		html break.


		html break.
		html submitButton
			callback: [ 
				self measures do: [ :each | each time: self time ].
				self answer: self measures ];
			text: 'Save'.
		html space.
		html cancelButton
			callback: [ self answer: nil ];
			text: 'Cancel' ]
]

{ #category : #accessing }
RecordBabyMeasurement >> time [

	^ time ifNil: [ time:= DateAndTime now ]
]

{ #category : #accessing }
RecordBabyMeasurement >> time: anObject [

	time := anObject
]
