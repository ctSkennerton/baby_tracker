Class {
	#name : #BabyView,
	#superclass : #WAComponent,
	#instVars : [
		'baby'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
BabyView >> baby [

	^ baby
]

{ #category : #accessing }
BabyView >> baby: anObject [

	baby := anObject
]

{ #category : #rendering }
BabyView >> renderContentOn: html [

	html form: [ 
		html text: 'Name: '.
		html textInput
			callback: [ :value | self baby name: value ];
			value: self baby name.
		html break.
		html dateInput5
			callback: [ :value | self baby dob: value asDate ];
			value: self baby dob.
		html break.

		html submitButton
			callback: [ self answer: self baby ];
			text: 'Save'.
		html cancelButton
			callback: [ self answer: nil ];
			text: 'Cancel' ]
]
