Class {
	#name : #RecordBabyMeasurement,
	#superclass : #WAComponent,
	#instVars : [
		'measures',
		'time'
	],
	#category : #BabyTracker
}

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

	html form: [ 
		html text: 'Time: '.
		html dateTimeLocalInput
			callback: [ :value | self time: value asDateAndTime ];
			value: (DatePrinter with: self time) isoLocal.
		html break.


		html text: 'Length: '.
		html numberInput callback: [ :value | 
			self measures add: (BabyMeasurement new
					 type: 'Length';
					 measurementValue: value asFloat;
					 units: 'in') ].

		html text: 'inches'.
		html break.

		html text: 'Weight: '.
		html numberInput callback: [ :value | 
			self measures add: (BabyMeasurement new
					 type: 'Weight';
					 measurementValue: value asFloat;
					 units: 'lb') ].

		html text: 'pounds'.
		html break.

		html text: 'Head Circumference: '.
		html numberInput callback: [ :value | 
			self measures add: (BabyMeasurement new
					 type: 'Head Circumference';
					 measurementValue: value asFloat;
					 units: 'in') ].

		html text: 'inches'.
		html break.


		html break.
		html submitButton
			callback: [ self answer: self measures ];
			text: 'Save'.
		html cancelButton
			callback: [ self answer: nil ];
			text: 'Cancel' ]
]

{ #category : #accessing }
RecordBabyMeasurement >> time [

	^ time
]

{ #category : #accessing }
RecordBabyMeasurement >> time: anObject [

	time := anObject
]
