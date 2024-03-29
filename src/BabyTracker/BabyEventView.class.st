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

{ #category : #'as yet unclassified' }
BabyEventView >> defaultFormDivCssClass [
			
	^ 'mb-3'
]

{ #category : #rendering }
BabyEventView >> renderContentOn: html [

	html form
		class: 'row';
		with: [ 
			self renderFormFieldsOn: html.
			html div
				class: self defaultFormDivCssClass ;
				with: [ 
					html submitButton
						class: 'btn btn-success';
						callback: [ self answer: self babyEvent ];
						text: 'Show'.
					html space.
					html cancelButton
						class: 'btn btn-secondary';
						callback: [ self answer: nil ];
						text: 'Cancel' ] ]
]

{ #category : #rendering }
BabyEventView >> renderFormFieldsOn: html [

	html div
		class: 'mb-3';
		with: [ 
	self renderStartTimeOn: html]
]

{ #category : #rendering }
BabyEventView >> renderStartTimeOn: html [

	html label
		for: 'start-time';
		with: 'Start: '.
	html dateTimeLocalInput
		id: 'start-time';
		class: 'form-control';
		attributeAt: 'step' put: '1';
		callback: [ :value | self babyEvent startTime: value asDateAndTime ];
		value: (DatePrinter with: self babyEvent startTime) isoLocal
]

{ #category : #actions }
BabyEventView >> save [

	self inform:
		self babyEvent
]
