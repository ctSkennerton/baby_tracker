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
		html text: 'Start: '.
		html textInput
			callback: [ :value | self babyEvent startTime: value ];
			value: self babyEvent startTime.
		html break.
		html text: 'End: '.
		html textInput
			callback: [ :value | self babyEvent endTime: value ];
			value: self babyEvent endTime.
		html break.
		html text: 'Type: '.
		html textInput
			callback: [ :value | self babyEvent type value ];
			value: self babyEvent type.
		html break.
		html submitButton
			callback: [ self save ];
			value: 'Save' ]
]

{ #category : #actions }
BabyEventView >> save [

	self inform:
		self babyEvent type , ' @ ' , self babyEvent startTime , ' - '
		, self babyEvent endTime
]
