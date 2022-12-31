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

	| firstSideRadioGroup secondSideRadioGroup |
	html form: [ 
		html text: 'Start: '.
		html dateTimeLocalInput
			callback: [ :value | self babyEvent startTime: value asDateAndTime ];
			value: (DatePrinter with: self babyEvent startTime) isoMinuteLocal.
		html break.
		(self babyEvent isKindOf: DurationBabyEvent) ifTrue: [ 
			html text: 'End: '.
			html dateTimeLocalInput
				callback: [ :value | self babyEvent endTime: value asDateAndTime ];
				value: (DatePrinter with: self babyEvent endTime) isoMinuteLocal ].
		html break.
		(self babyEvent isKindOf: DaiperChangeEvent) ifTrue: [ 
			html text: 'Daiper Type: '.
			html select
				list: { 'Mixed'. 'Pee'. 'Poop'. 'Dry' };
				selected: self babyEvent daiperType;
				callback: [ :value | self babyEvent daiperType: value ] ].
		(self babyEvent isKindOf: NursingEvent) ifTrue: [ "Radio Buttons"
			html text: 'First Side: '.
			firstSideRadioGroup := html radioGroup.
			firstSideRadioGroup radioButton
				selected: self babyEvent firstSide = 'Right';
				callback: [ self babyEvent firstSide: 'Right' ].
			html text: 'Right'.
			html space.
			firstSideRadioGroup radioButton
				selected: self babyEvent firstSide = 'Left';
				callback: [ self babyEvent firstSide: 'Left' ].

			html text: 'Left'.
			html break.
			html text: 'Second Side: '.
			secondSideRadioGroup := html radioGroup.
			secondSideRadioGroup radioButton
				selected: self babyEvent secondSide = 'Right';
				callback: [ self babyEvent secondSide: 'Right' ].
			html text: 'Right'.
			html space.
			secondSideRadioGroup radioButton
				selected: self babyEvent secondSide = 'Left';
				callback: [ self babyEvent secondSide: 'Left' ].
			html text: 'Left'.
			html space.
			secondSideRadioGroup radioButton
				selected: self babyEvent secondSide isNil;
				callback: [ self babyEvent secondSide: nil ].
			html text: 'None' ].

		html break.
		html submitButton
			callback: [ self answer: self babyEvent ];
			text: 'Save'.
		html space.
		html cancelButton
			callback: [ self answer: nil ];
			text: 'Cancel' ]
]

{ #category : #actions }
BabyEventView >> save [

	self inform:
		self babyEvent
]
