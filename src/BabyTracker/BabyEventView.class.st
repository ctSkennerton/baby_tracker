Class {
	#name : #BabyEventView,
	#superclass : #WAComponent,
	#instVars : [
		'babyEvent'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
BabyEventView >> babyEvent [

	^ babyEvent ifNil: [ babyEvent := BabyEvent events first ]
]

{ #category : #accessing }
BabyEventView >> babyEvent: aBabyEvent [

	babyEvent := aBabyEvent 
]

{ #category : #rendering }
BabyEventView >> renderContentOn: html [


	html form: [ 
		self renderFormFieldsOn: html.

		html submitButton
			callback: [ self answer: self babyEvent ];
			text: 'Save'.
		html space.
		html cancelButton
			callback: [ self answer: nil ];
			text: 'Cancel' ]
]

{ #category : #rendering }
BabyEventView >> renderFormFieldsOn: html [

	self renderStartTimeOn: html
]

{ #category : #rendering }
BabyEventView >> renderStartTimeOn: html [

		html label
		for: 'start-time';
		with: 'Start: '.
	html dateTimeLocalInput
		id: 'start-time';
		attributeAt: 'step' put: '1';
		callback: [ :value | self babyEvent startTime: value asDateAndTime ];
		value: (DatePrinter with: self babyEvent startTime) isoLocal
]

{ #category : #actions }
BabyEventView >> save [

	self inform:
		self babyEvent
]
