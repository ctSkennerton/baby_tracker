Class {
	#name : #NursingEventView,
	#superclass : #DurationEventView,
	#category : #BabyTracker
}

{ #category : #rendering }
NursingEventView >> renderFormFieldsOn: html [

	"comment stating purpose of instance-side method"

	super renderFormFieldsOn: html.
	self renderNursingSideOn: html
]

{ #category : #rendering }
NursingEventView >> renderNursingSideOn: html [

	"comment stating purpose of instance-side method"

	| firstSideRadioGroup secondSideRadioGroup |
	html text: 'First Side: '.
			firstSideRadioGroup := html radioGroup.
			firstSideRadioGroup radioButton
				selected: self babyEvent firstSide = 'Left';
				callback: [ self babyEvent firstSide: 'Left' ].
			html text: 'Left'.
			html space.
			firstSideRadioGroup radioButton
				selected: self babyEvent firstSide = 'Right';
				callback: [ self babyEvent firstSide: 'Right' ].

			html text: 'Right'.
			html break.
			html text: 'Second Side: '.
			secondSideRadioGroup := html radioGroup.
			secondSideRadioGroup radioButton
				selected: self babyEvent secondSide = 'Left';
				callback: [ self babyEvent secondSide: 'Left' ].
			html text: 'Left'.
			html space.
			secondSideRadioGroup radioButton
				selected: self babyEvent secondSide = 'Right';
				callback: [ self babyEvent secondSide: 'Right' ].
			html text: 'Right'.
			html space.
			secondSideRadioGroup radioButton
				selected: self babyEvent secondSide isNil;
				callback: [ self babyEvent secondSide: nil ].
			html text: 'None'
]
