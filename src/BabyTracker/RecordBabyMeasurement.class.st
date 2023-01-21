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
		html label
			for: 'measurement-date-picker';
			with: 'Time: '.
		html dateTimeLocalInput
			callback: [ :value | self time: value asDateAndTime ];
			id: 'measurement-date-picker';
			class: 'form-control';
			attributeAt: 'step' put: '1';
			value: (DatePrinter with: self time) isoLocal.

		html label
			for: 'measurement-length-input';
			with: 'Length (in): '.
		html numberInput
			id: 'measurement-length-input';
			attributeAt: 'step' put: '0.01';
			class: 'form-control';
			callback: [ :value | 
				value ifNotEmpty: [ 
						self measures add: (BabyMeasurement new
									 type: 'Length';
									 measurementValue: value asNumber;
									 units: 'in') ] ].

		html label
			for: 'measurement-weight-input';
			with: 'Weight (lb): '.
		html numberInput
			id: 'measurement-weight-input';
			class: 'form-control';
			attributeAt: 'step' put: '0.01';
			callback: [ :value | 
				value ifNotEmpty: [ 
						self measures add: (BabyMeasurement new
									 type: 'Weight';
									 measurementValue: value asNumber;
									 units: 'lb') ] ].


		html label
			for: 'measurement-head-circ';
			with: 'Head Circumference (in): '.
		html numberInput
			id: 'measurement-head-circ';
			attributeAt: 'step' put: '0.01';
			class: 'form-control';
			callback: [ :value | 
				value ifNotEmpty: [ 
						self measures add: (BabyMeasurement new
									 type: 'Head Circumference';
									 measurementValue: value asNumber;
									 units: 'in') ] ].

		html submitButton
			class: 'btn btn-success';
			callback: [ 
				self measures do: [ :each | each time: self time ].
				self answer: self measures ];
			text: 'Save'.
		html space.
		html cancelButton
			class: 'btn btn-secondary';
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
